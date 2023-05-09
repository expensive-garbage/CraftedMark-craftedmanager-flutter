import 'dart:async';

import 'package:crafted_manager/Orders/database_functions.dart'; // Replace path/to/ with the correct path

class OrderPostgres {
  static Future<List<Map<String, dynamic>>> fetchAllOrders() async {
    final connection = await connectToPostgres();
    final results = await connection
        .query('SELECT * FROM orders'); // Replace 'orders' with your table name

    List<Map<String, dynamic>> orders = [];
    for (final row in results) {
      orders.add(row.toColumnMap());
    }

    await connection.close();
    return orders;
  }
}
