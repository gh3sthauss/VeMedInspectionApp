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

    unawaited(drainPending());
  }

  /// Uploads every queued photo it can. Safe to call repeatedly/concurrently.
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
  }

  Future<void> _drainOne(PendingUpload item) async {
    final file = File(item.bytesCachePath);
    if (!await file.exists()) {
      // Cached bytes are gone (e.g. cache cleared) - nothing more we can do.
      await _db!.delete('pending_uploads', where: 'id = ?', whereArgs: [item.id]);
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
  }
}
