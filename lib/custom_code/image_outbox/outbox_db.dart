import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _createPendingUploads = '''
  CREATE TABLE pending_uploads (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bytes_cache_path TEXT NOT NULL,
    storage_path TEXT NOT NULL,
    collection_path TEXT NOT NULL,
    doc_id TEXT NOT NULL,
    array_field_name TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    attempt_count INTEGER NOT NULL DEFAULT 0,
    last_error TEXT,
    created_at INTEGER NOT NULL
  )
''';

// Photos removed while offline: the Firestore arrayRemove is queued by
// Firestore's own persistence, but the Storage object still needs deleting
// once connectivity returns. This table is that queue, so a removed photo
// never leaves an orphaned file behind.
const _createPendingDeletions = '''
  CREATE TABLE pending_deletions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    download_url TEXT NOT NULL,
    attempt_count INTEGER NOT NULL DEFAULT 0,
    last_error TEXT,
    created_at INTEGER NOT NULL
  )
''';

/// Independent local database for queued photo uploads. Deliberately
/// separate from FlutterFlow's generated `local_d_b.db` (lib/backend/sqlite/)
/// so this file is never touched by a FlutterFlow re-export.
Future<Database> openOutboxDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'image_outbox.db');
  return openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      await db.execute(_createPendingUploads);
      await db.execute(_createPendingDeletions);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute(_createPendingDeletions);
      }
    },
  );
}
