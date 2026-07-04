class PendingUpload {
  PendingUpload({
    required this.id,
    required this.bytesCachePath,
    required this.storagePath,
    required this.collectionPath,
    required this.docId,
    required this.arrayFieldName,
    required this.attemptCount,
  });

  factory PendingUpload.fromRow(Map<String, dynamic> row) => PendingUpload(
        id: row['id'] as int,
        bytesCachePath: row['bytes_cache_path'] as String,
        storagePath: row['storage_path'] as String,
        collectionPath: row['collection_path'] as String,
        docId: row['doc_id'] as String,
        arrayFieldName: row['array_field_name'] as String,
        attemptCount: row['attempt_count'] as int,
      );

  final int id;
  final String bytesCachePath;
  final String storagePath;
  final String collectionPath;
  final String docId;
  final String arrayFieldName;
  final int attemptCount;
}
