import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Independent local database for queued photo uploads. Deliberately
/// separate from FlutterFlow's generated `local_d_b.db` (lib/backend/sqlite/)
/// so this file is never touched by a FlutterFlow re-export.
Future<Database> openOutboxDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'image_outbox.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) => db.execute('''
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
    '''),
  );
}
