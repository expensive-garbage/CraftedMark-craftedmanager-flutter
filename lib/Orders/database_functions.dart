import 'dart:convert';

import 'package:crafted_manager/postgres.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Fetches the schema for the specified table
Future<List<Map<String, dynamic>>> fetchTableSchema(String tableName) async {
  final result = await postgre.query(
      'SELECT column_name, data_type FROM information_schema.columns WHERE table_name = @tableName',
      substitutionValues: {'tableName': tableName});

  if (kDebugMode) {
    debugPrint('Fetched $tableName schema: $result');
  }

  return result.map((row) => row.toColumnMap()).toList();
}

// Fetches the schema for all tables in the database and stores them in SharedPreferences
Future<void> fetchAndStoreAllSchemas() async {
  final result = await postgre.query(
      "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'");

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
