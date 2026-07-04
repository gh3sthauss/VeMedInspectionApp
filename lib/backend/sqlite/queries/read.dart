import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GETNOTES
Future<List<GetNotesRow>> performGetNotes(
  Database database,
) {
  final query = '''
Select * from Notes
''';
  return _readQuery(database, query, (d) => GetNotesRow(d));
}

class GetNotesRow extends SqliteRow {
  GetNotesRow(Map<String, dynamic> data) : super(data);

  int get id => data['ID'] as int;
  String? get note => data['Note'] as String?;
}

/// END GETNOTES
