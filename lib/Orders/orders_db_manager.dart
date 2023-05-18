import 'dart:core';

import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
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

  static Future<void> updateOrder(
      Order order, List<OrderedItem> orderedItems) async {
    try {
      await _connection.transaction((ctx) async {
        // Update order in orders table
        await ctx.query('''
        UPDATE orders
        SET people_id = @customerId, order_date = @orderDate, shipping_address = @shippingAddress, billing_address = @billingAddress, total_amount = @totalAmount, order_status = @orderStatus
        WHERE order_id = @id
      ''', substitutionValues: order.toMap());

        // Delete existing ordered items for this order
        await ctx.query('''
        DELETE FROM ordered_items WHERE order_id = @orderId
      ''', substitutionValues: {
          'orderId': order.id,
        });

        // Insert updated ordered items into ordered_items table
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

  static Future<List<Order>> getAllOrders() async {
    try {
      List<Order> orders = [];
      List<Map<String, Map<String, dynamic>>> results =
          await _connection.mappedResultsQuery('''
      SELECT * FROM orders
    ''');

      for (var row in results) {
        orders.add(Order.fromMap(row.values.first));
      }

      return orders;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<Order> getOrderById(String id) async {
    try {
      List<Map<String, Map<String, dynamic>>> results =
          await _connection.mappedResultsQuery('''
      SELECT * FROM orders WHERE order_id = @id
    ''', substitutionValues: {
        'id': id,
      });

      if (results.isNotEmpty) {
        return Order.fromMap(results.first.values.first);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> deleteOrder(String id) async {
    try {
      await _connection.transaction((ctx) async {
        // Delete ordered items for this order
        await ctx.query('''
        DELETE FROM ordered_items WHERE order_id = @orderId
      ''', substitutionValues: {
          'orderId': id,
        });

        // Delete order from orders table
        await ctx.query('''
        DELETE FROM orders WHERE order_id = @id
      ''', substitutionValues: {
          'id': id,
        });
      });
    } catch (e) {
      print(e.toString());
    }
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
}
