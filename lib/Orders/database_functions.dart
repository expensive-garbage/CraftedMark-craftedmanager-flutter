import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Establishes a connection to the PostgreSQL database
Future<PostgreSQLConnection> connectToPostgres() async {
  final connection = PostgreSQLConnection(
    'web.craftedsolutions.co', // Database host
    5432, // Port number
    'craftedmanager_db', // Database name
    username: 'craftedmanager_dbuser', // Database username
    password: '!!Laganga1983', // Database password
  );

  await connection.open();
  debugPrint('Connected to PostgreSQL');
  return connection;
}

// Fetches the schema for the specified table
Future<List<Map<String, dynamic>>> fetchTableSchema(String tableName) async {
  final connection = await connectToPostgres();
  final result = await connection.query(
      'SELECT column_name, data_type FROM information_schema.columns WHERE table_name = @tableName',
      substitutionValues: {'tableName': tableName});
  await connection.close();
  debugPrint('Closed connection to PostgreSQL');

  if (kDebugMode) {
    debugPrint('Fetched $tableName schema: $result');
  }

  return result != null ? result.map((row) => row.toColumnMap()).toList() : [];
}

// Fetches the schema for all tables in the database and stores them in SharedPreferences
Future<void> fetchAndStoreAllSchemas() async {
  final connection = await connectToPostgres();
  final result = await connection.query(
      "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'");
  await connection.close();
  debugPrint('Closed connection to PostgreSQL');

  if (result != null) {
    final allSchemas = <String, List<Map<String, dynamic>>>{};
    for (final row in result) {
      final tableName = row[0].toString();
      final schema = await fetchTableSchema(tableName);
      allSchemas[tableName] = schema;
    }
    final jsonString = jsonEncode(allSchemas);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('all_schemas', jsonString);
    debugPrint('Stored all schemas in SharedPreferences');
  } else {
    debugPrint('Could not fetch schemas for all tables');
  }
}

// Fetches the schema for the specified table from SharedPreferences
Future<List<Map<String, dynamic>>> fetchStoredSchema(String tableName) async {
  final preferences = await SharedPreferences.getInstance();
  final jsonString = preferences.getString('all_schemas');
  if (jsonString != null) {
    final allSchemas = jsonDecode(jsonString);
    if (allSchemas.containsKey(tableName)) {
      return List<Map<String, dynamic>>.from(allSchemas[tableName]);
    } else {
      debugPrint('Schema for $tableName not found in SharedPreferences');
    }
  } else {
    debugPrint('No schemas found in SharedPreferences');
  }
  return [];
}
