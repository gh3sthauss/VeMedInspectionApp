import 'package:sqflite/sqflite.dart';

/// BEGIN ADDTEST
Future performAddTest(
  Database database, {
  String? noteVal,
}) {
  final query = '''
INSERT INTO Deneme (Note) VALUES ('${noteVal}');
''';
  return database.rawQuery(query);
}

/// END ADDTEST
