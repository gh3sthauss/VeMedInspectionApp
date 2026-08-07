import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '/backend/firebase_storage/storage.dart';
import 'outbox_db.dart';
import 'pending_upload.dart';

/// Queues photo uploads locally so they survive being offline for hours,
/// then drains them to Firebase Storage + Firestore once connectivity
/// returns. Firebase Storage itself has no offline queue, so this exists to
/// give it one. Not available on web (sqflite has no web backend in this
/// project) — web keeps the direct upload-or-fail-gracefully behavior.
class ImageOutboxManager {
  ImageOutboxManager._();
  static final ImageOutboxManager instance = ImageOutboxManager._();

  Database? _db;
  bool _draining = false;

  /// Bumps whenever the pending set changes (enqueue, upload success, remove).
  /// Preview widgets listen to this so a queued photo shows up immediately
  /// offline and disappears once it has finished uploading.
  final ValueNotifier<int> changes = ValueNotifier<int>(0);
  void _notify() => changes.value++;

  Future<void> init() async {
    if (kIsWeb) return;
    _db = await openOutboxDatabase();
  }

  /// Called when a photo is picked. Caches the bytes to disk, queues a row,
  /// and makes one opportunistic attempt in case connectivity is already up.
  Future<void> enqueue({
    required Uint8List bytes,
    required String storagePath,
    required String collectionPath,
    required String docId,
    required String arrayFieldName,
  }) async {
    if (kIsWeb || _db == null) return;

    final cacheDir = await getApplicationSupportDirectory();
    final outboxDir = Directory(join(cacheDir.path, 'image_outbox'));
    if (!await outboxDir.exists()) {
      await outboxDir.create(recursive: true);
    }
    final cachePath = join(outboxDir.path, '${const Uuid().v4()}.bin');
    await File(cachePath).writeAsBytes(bytes, flush: true);

    await _db!.insert('pending_uploads', {
      'bytes_cache_path': cachePath,
      'storage_path': storagePath,
      'collection_path': collectionPath,
      'doc_id': docId,
      'array_field_name': arrayFieldName,
      'status': 'pending',
      'attempt_count': 0,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
    // Row is now persisted — let previews pick it up right away, even offline.
    _notify();

    unawaited(drainPending());
  }

  /// Pending (not-yet-uploaded) photos queued for one document field, oldest
  /// first. Used to render local previews before the upload has synced.
  Future<List<PendingUpload>> pendingFor({
    required String collectionPath,
    required String docId,
    required String arrayFieldName,
  }) async {
    if (kIsWeb || _db == null) return const [];
    final rows = await _db!.query(
      'pending_uploads',
      where: 'collection_path = ? AND doc_id = ? AND array_field_name = ?',
      whereArgs: [collectionPath, docId, arrayFieldName],
      orderBy: 'created_at ASC, id ASC',
    );
    return rows.map(PendingUpload.fromRow).toList();
  }

  /// The locally-cached bytes for a pending upload, or null if the cache file
  /// is gone.
  Future<Uint8List?> readPendingBytes(PendingUpload item) async {
    final file = File(item.bytesCachePath);
    if (!await file.exists()) return null;
    return file.readAsBytes();
  }

  /// Cancels a still-pending upload: drops the queue row and its cached bytes.
  /// Nothing was uploaded yet, so there is no Storage object to clean up.
  Future<void> removePending(int id) async {
    if (kIsWeb || _db == null) return;
    final rows =
        await _db!.query('pending_uploads', where: 'id = ?', whereArgs: [id]);
    for (final row in rows) {
      final item = PendingUpload.fromRow(row);
      final file = File(item.bytesCachePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await _db!.delete('pending_uploads', where: 'id = ?', whereArgs: [id]);
    _notify();
  }

  /// Queues an already-uploaded photo's Storage object for deletion. The
  /// caller has already removed the URL from the Firestore document (which
  /// Firestore syncs on its own); this ensures the underlying file is deleted
  /// too, retrying until connectivity allows it.
  Future<void> enqueueDeletion(String downloadUrl) async {
    if (kIsWeb || _db == null) return;
    await _db!.insert('pending_deletions', {
      'download_url': downloadUrl,
      'attempt_count': 0,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
    unawaited(drainDeletions());
  }

  /// Uploads every queued photo it can, then drains queued deletions. Safe to
  /// call repeatedly/concurrently.
  Future<void> drainPending() async {
    if (kIsWeb || _db == null || _draining) return;
    _draining = true;
    try {
      final rows = await _db!.query('pending_uploads');
      for (final row in rows) {
        await _drainOne(PendingUpload.fromRow(row));
      }
    } finally {
      _draining = false;
    }
    await drainDeletions();
  }

  Future<void> _drainOne(PendingUpload item) async {
    final file = File(item.bytesCachePath);
    if (!await file.exists()) {
      // Cached bytes are gone (e.g. cache cleared) - nothing more we can do.
      await _db!.delete('pending_uploads', where: 'id = ?', whereArgs: [item.id]);
      _notify();
      return;
    }

    final bytes = await file.readAsBytes();
    final url = await uploadData(item.storagePath, bytes);

    if (url == null) {
      await _db!.update(
        'pending_uploads',
        {
          'attempt_count': item.attemptCount + 1,
          'last_error': 'upload failed (offline or storage error)',
        },
        where: 'id = ?',
        whereArgs: [item.id],
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection(item.collectionPath)
        .doc(item.docId)
        .update({
      item.arrayFieldName: FieldValue.arrayUnion([url]),
    });

    await _db!.delete('pending_uploads', where: 'id = ?', whereArgs: [item.id]);
    if (await file.exists()) {
      await file.delete();
    }
    // Upload done — drop the local preview; the real URL now renders instead.
    _notify();
  }

  /// Deletes queued Storage objects for photos removed while offline. Rows are
  /// only dropped on confirmed deletion so nothing is orphaned.
  Future<void> drainDeletions() async {
    if (kIsWeb || _db == null) return;
    final rows = await _db!.query('pending_deletions');
    for (final row in rows) {
      final id = row['id'] as int;
      final url = row['download_url'] as String;
      final ok = await deleteDataByUrl(url);
      if (ok) {
        await _db!.delete('pending_deletions', where: 'id = ?', whereArgs: [id]);
      } else {
        await _db!.update(
          'pending_deletions',
          {'attempt_count': (row['attempt_count'] as int) + 1},
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }
  }
}
