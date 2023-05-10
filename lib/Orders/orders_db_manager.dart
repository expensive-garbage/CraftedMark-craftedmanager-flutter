import 'dart:core';

import 'package:crafted_manager/models/order_model.dart';
import 'package:crafted_manager/models/ordered_item_model.dart';
import 'package:postgres/postgres.dart';

class OrderPostgres {
  static final _connection = PostgreSQLConnection(
    'web.craftedsolutions.co', // Database host
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

  static Future<void> createOrder(
      Order order, List<OrderedItem> orderedItems) async {
    try {
      await _connection.transaction((ctx) async {
        // Insert order into orders table
        await ctx.query('''
        INSERT INTO orders (order_id, people_id, order_date, shipping_address, billing_address, total_amount, order_status)
        VALUES (@id, @customerId, @orderDate, @shippingAddress, @billingAddress, @totalAmount, @orderStatus)
      ''', substitutionValues: order.toMap());

        // Insert ordered items into ordered_items table
        for (OrderedItem item in orderedItems) {
          await ctx.query('''
          INSERT INTO ordered_items (order_id, product_id, quantity, price, discount, description)
          VALUES (@orderId, @productId, @quantity, @price, @discount, @description)
        ''', substitutionValues: {
            ...item.toMap(),
            'orderId': order.id,
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAllOrders() async {
    List<Map<String, dynamic>> orderList = [];

    try {
      var results = await _connection.query('SELECT * FROM orders');
      for (var row in results) {
        Map<String, dynamic> order = {
          "order_id": row['order_id'],
          "people_id": row['people_id'],
          "order_date": row['order_date'],
          "shipping_address": row['shipping_address'],
          "billing_address": row['billing_address'],
          "total_amount": row['total_amount'],
          "order_status": row['order_status'],
        };
        orderList.add(order);
      }
    } catch (e) {
      print(e.toString());
    }
    return orderList;
  }
}
