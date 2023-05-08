import 'dart:core';

import 'package:postgres/postgres.dart';
import 'package:crafted_manager/utils.dart';

class OrderPostgres {
  static final _connection = PostgreSQLConnection(
    'localhost', // Database host
    5432, // Port number
    'craftedmanager_db', // Database name
    username: 'craftedmanager_dbuser', // Database username
    password: '!!Laganga1983', // Database password
  );

  static Future<void> openConnection() async {
    await _connection.open();
  }

  static Future<void> closeConnection() async {
    await _connection.close();
  }

  static Future<List<Map<String, dynamic>>> fetchAllOrders() async {
    List<Map<String, dynamic>> orderList = [];

    try {
      var results = await _connection.query('SELECT * FROM orders');
      for (var row in results) {
        Map<String, dynamic> order = {
          "order_id": row.get(columnName: 'order_id'),
          "people_id": row.get(columnName: 'people_id'),
          "order_date": row.get(columnName: 'order_date'),
          "shipping_address": row.get(columnName: 'shipping_address'),
          "billing_address": row.get(columnName: 'billing_address'),
          "total_amount": row.get(columnName: 'total_amount'),
          "order_status": row.get(columnName: 'order_status'),
        };
        orderList.add(order);
      }
    } catch (e) {
      print(e.toString());
    }
    return orderList;
  }
}
