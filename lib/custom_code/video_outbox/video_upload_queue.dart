// Videos go straight to Google Drive, never through Firebase Storage.
//
// Picking a video copies it into the app's storage and queues it here (so it
// survives being offline or the app closing). When there's signal, the
// `driveVideo` Cloud Function opens a resumable Drive upload session for it
// and the phone uploads the file to that session in chunks, resuming where it
// stopped after a dropped connection. Once Drive has the whole file, the
// report's `SysGenVideos` list gets {id, name, size} and `SysGenVideoFolderUrl`
// the folder link used in the PDF.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

const _videoUrl =
    'https://us-central1-ve-med-on7ngs.cloudfunctions.net/driveVideo';

/// Drive requires chunks in multiples of 256 KiB (except the last one).
const _chunkBytes = 32 * 256 * 1024; // 8 MiB

const kVideosField = 'SysGenVideos';
const kVideoFolderUrlField = 'SysGenVideoFolderUrl';

class PendingVideo {
  PendingVideo(Map<String, Object?> row)
      : id = row['id'] as int,
        collection = row['collection'] as String,
        docId = row['doc_id'] as String,
        title = row['title'] as String,
        filePath = row['file_path'] as String,
        fileName = row['file_name'] as String,
        mime = row['mime'] as String,
        size = row['size'] as int,
        sessionUrl = row['session_url'] as String?,
        folderUrl = row['folder_url'] as String?;

  final int id;
  final String collection;
  final String docId;
  final String title;
  final String filePath;
  final String fileName;
  final String mime;
  final int size;
  final String? sessionUrl;
  final String? folderUrl;
}

/// Thrown by Drive video requests the user should hear about (e.g. no
/// connection when removing a video).
class VideoRequestError implements Exception {
  VideoRequestError(this.message);
  final String message;
  @override
  String toString() => message;
}

class VideoUploadQueue {
  VideoUploadQueue._();
  static final VideoUploadQueue instance = VideoUploadQueue._();

  Database? _db;
  bool _draining = false;

  /// Bumps when the queue changes; widgets listen to refresh.
  final ValueNotifier<int> changes = ValueNotifier<int>(0);

  /// Upload progress 0..1 per queued video id.
  final ValueNotifier<Map<int, double>> progress =
      ValueNotifier<Map<int, double>>({});

  void _notify() => changes.value++;

  void _setProgress(int id, double value) {
    progress.value = {...progress.value, id: value};
  }

  Future<void> init() async {
    if (kIsWeb) return;
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'video_outbox.db'),
      version: 1,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE jobs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          collection TEXT NOT NULL,
          doc_id TEXT NOT NULL,
          title TEXT NOT NULL,
          file_path TEXT NOT NULL,
          file_name TEXT NOT NULL,
          mime TEXT NOT NULL,
          size INTEGER NOT NULL,
          session_url TEXT,
          folder_url TEXT,
          created_at INTEGER NOT NULL
        )'''),
    );
  }

  Future<List<PendingVideo>> pendingFor(String collection, String docId) async {
    final db = _db;
    if (db == null) return const [];
    final rows = await db.query('jobs',
        where: 'collection = ? AND doc_id = ?',
        whereArgs: [collection, docId],
        orderBy: 'id');
    return rows.map(PendingVideo.new).toList();
  }

  /// Copies the picked video into app storage and queues it for upload.
  Future<void> enqueue({
    required String collection,
    required String docId,
    required String title,
    required String sourcePath,
  }) async {
    final db = _db;
    if (db == null) return;
    final ext = p.extension(sourcePath).toLowerCase();
    final dir = Directory(
        p.join((await getApplicationSupportDirectory()).path, 'video_outbox'));
    await dir.create(recursive: true);
    final dest = p.join(dir.path, '${const Uuid().v4()}$ext');
    await File(sourcePath).copy(dest); // streamed, not loaded into memory
    final size = await File(dest).length();
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    final name = 'System General video ${now.year}-${two(now.month)}-'
        '${two(now.day)} ${two(now.hour)}.${two(now.minute)}.${two(now.second)}'
        '${ext.isEmpty ? '.mp4' : ext}';
    await db.insert('jobs', {
      'collection': collection,
      'doc_id': docId,
      'title': title,
      'file_path': dest,
      'file_name': name,
      'mime': ext == '.mov' ? 'video/quicktime' : 'video/mp4',
      'size': size,
      'created_at': now.millisecondsSinceEpoch,
    });
    _notify();
    unawaited(drainPending());
  }

  /// Drops a queued (not yet uploaded) video.
  Future<void> cancel(int id) async {
    final db = _db;
    if (db == null) return;
    final rows = await db.query('jobs', where: 'id = ?', whereArgs: [id]);
    if (rows.isNotEmpty) {
      try {
        await File(rows.first['file_path'] as String).delete();
      } catch (_) {}
    }
    await db.delete('jobs', where: 'id = ?', whereArgs: [id]);
    progress.value = {...progress.value}..remove(id);
    _notify();
  }

  /// Uploads everything queued, oldest first. Stops at the first failure
  /// (usually no signal); called again on reconnect / app start.
  Future<void> drainPending() async {
    final db = _db;
    if (db == null || _draining) return;
    _draining = true;
    try {
      final rows = await db.query('jobs', orderBy: 'id');
      for (final row in rows) {
        final job = PendingVideo(row);
        try {
          await _upload(job);
        } catch (e) {
          debugPrint('Video upload paused: $e');
          // Back to "Waiting for connection" until the next attempt.
          progress.value = {...progress.value}..remove(job.id);
          break;
        }
      }
    } finally {
      _draining = false;
    }
  }

  Future<Map<String, dynamic>> _call(Map<String, dynamic> data) async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) throw VideoRequestError('Not signed in.');
    final res = await http
        .post(Uri.parse(_videoUrl),
            headers: {
              'X-Firebase-Auth': idToken,
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'data': data}))
        .timeout(const Duration(seconds: 45));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode != 200) {
      throw VideoRequestError(body['error']?.toString() ?? 'Request failed.');
    }
    return body['result'] as Map<String, dynamic>;
  }

  Future<void> _upload(PendingVideo job) async {
    final db = _db!;
    final file = File(job.filePath);
    if (!await file.exists()) {
      await cancel(job.id);
      return;
    }
    // Shows "Uploading" (rather than "Waiting for connection") from the
    // first request on.
    _setProgress(job.id, progress.value[job.id] ?? 0);
    var sessionUrl = job.sessionUrl;
    var folderUrl = job.folderUrl;
    if (sessionUrl == null) {
      final r = await _call({
        'action': 'start',
        'reportKey': '${job.collection}_${job.docId}',
        'title': job.title,
        'fileName': job.fileName,
        'mimeType': job.mime,
        'size': job.size,
      });
      sessionUrl = r['sessionUrl'] as String;
      folderUrl = r['folderUrl'] as String;
      await db.update('jobs', {'session_url': sessionUrl, 'folder_url': folderUrl},
          where: 'id = ?', whereArgs: [job.id]);
    }

    // Where did Drive get to? (0 for a fresh session.)
    var offset = 0;
    final status = await http.put(Uri.parse(sessionUrl), headers: {
      'Content-Range': 'bytes */${job.size}',
    }).timeout(const Duration(seconds: 45));
    if (status.statusCode == 200 || status.statusCode == 201) {
      return _finish(job, status.body, folderUrl!);
    } else if (status.statusCode == 308) {
      offset = _nextOffset(status.headers['range']);
    } else if (status.statusCode == 404 || status.statusCode == 410) {
      // Session expired (they last a week): start over with a new one.
      await db.update('jobs', {'session_url': null},
          where: 'id = ?', whereArgs: [job.id]);
      throw VideoRequestError('Upload session expired; restarting.');
    } else {
      throw VideoRequestError('Drive status ${status.statusCode}');
    }

    final raf = await file.open();
    try {
      while (true) {
        _setProgress(job.id, offset / job.size);
        await raf.setPosition(offset);
        final chunk = await raf.read(_chunkBytes);
        final end = offset + chunk.length - 1;
        final res = await http
            .put(Uri.parse(sessionUrl),
                headers: {
                  'Content-Range': 'bytes $offset-$end/${job.size}',
                },
                body: chunk)
            .timeout(const Duration(minutes: 3));
        if (res.statusCode == 200 || res.statusCode == 201) {
          return _finish(job, res.body, folderUrl!);
        }
        if (res.statusCode != 308) {
          throw VideoRequestError('Drive upload status ${res.statusCode}');
        }
        offset = _nextOffset(res.headers['range']);
      }
    } finally {
      await raf.close();
    }
  }

  /// Drive's "Range: bytes=0-N" means it has N+1 bytes.
  int _nextOffset(String? range) {
    final m = RegExp(r'bytes=0-(\d+)').firstMatch(range ?? '');
    return m == null ? 0 : int.parse(m.group(1)!) + 1;
  }

  Future<void> _finish(PendingVideo job, String body, String folderUrl) async {
    final fileId = (jsonDecode(body) as Map<String, dynamic>)['id'] as String;
    unawaited(FirebaseFirestore.instance
        .collection(job.collection)
        .doc(job.docId)
        .update({
      kVideosField: FieldValue.arrayUnion([
        {'id': fileId, 'name': job.fileName, 'size': job.size},
      ]),
      kVideoFolderUrlField: folderUrl,
    }));
    try {
      await File(job.filePath).delete();
    } catch (_) {}
    await _db!.delete('jobs', where: 'id = ?', whereArgs: [job.id]);
    progress.value = {...progress.value}..remove(job.id);
    _notify();
  }

  /// Removes an uploaded video from Drive and from the report. Needs signal.
  Future<void> deleteUploaded({
    required String collection,
    required String docId,
    required Map<String, dynamic> video,
  }) async {
    try {
      await _call({
        'action': 'delete',
        'reportKey': '${collection}_$docId',
        'fileId': video['id'],
      });
    } on VideoRequestError {
      rethrow;
    } catch (_) {
      throw VideoRequestError(
          "Couldn't reach Google Drive. Try again with a connection.");
    }
    unawaited(FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .update({
      kVideosField: FieldValue.arrayRemove([video]),
    }));
  }
}
