import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

Future<PostgreSQLConnection> connectToPostgres() async {
  final connection = PostgreSQLConnection(
    'localhost',
    5432,
    'craftedmanager_db',
    username: 'craftedmanager_dbuser',
    password: '!!Laganga1983',
  );

  await connection.open();
  return connection;
}

Future<List<Map<String, dynamic>>> fetchData(String tableName) async {
  final connection = await connectToPostgres();
  final result = await connection.query('SELECT * FROM $tableName');
  await connection.close();

  return result.map((row) => row.toColumnMap()).toList();
}

Future<void> insertData(String tableName, Map<String, dynamic> data) async {
  final connection = await connectToPostgres();
  final columns = data.keys.join(', ');
  final values = data.keys.map((key) => '@$key').join(', ');

  await connection.execute(
    'INSERT INTO $tableName ($columns) VALUES ($values)',
    substitutionValues: data,
  );
  await connection.close();
}

Future<void> updateData(String tableName, int id, Map<String, dynamic> updatedData) async {
  final connection = await connectToPostgres();
  final updates = updatedData.keys.map((key) => '$key = @$key').join(', ');

  await connection.execute(
    'UPDATE $tableName SET $updates WHERE id = @id',
    substitutionValues: {...updatedData, 'id': id},
  );
  await connection.close();
}

Future<void> deleteData(String tableName, int id) async {
  final connection = await connectToPostgres();
  await connection.execute('DELETE FROM $tableName WHERE id = @id', substitutionValues: {'id': id});
  await connection.close();
}

Future<List<Map<String, dynamic>>> searchData(String tableName, String searchQuery) async {
  final connection = await connectToPostgres();
  final result = await connection.query('SELECT * FROM $tableName WHERE $searchQuery');
  await connection.close();

  return result.map((row) => row.toColumnMap()).toList();
}

void main() async {
  // Example usage
  final peopleData = await fetchData('people');
  if (kDebugMode) {
    print(peopleData);
  }
}
