import 'package:postgres/postgres.dart';
import 'package:async/async.dart';
import 'package:uuid/uuid.dart';
import 'dart:core';
import 'package:crafted_manager/postgres.dart';
import 'package:crafted_manager/Models/product_model.dart';

class ProductPostgres {
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

  static Future<List<Product>> getAllProducts() async {
    final results = await _connection.query('SELECT * FROM products');
    return results.map((row) => Product.fromMap(row.toColumnMap())).toList();
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

    static Future<List<Map<String, dynamic>>> searchProducts(
        String keyword) async {
      final results = await _connection.query(
          'SELECT * FROM products WHERE name ILIKE @keyword OR description ILIKE @keyword',
          substitutionValues: {'keyword': '%$keyword%'});
      return results.map((row) => row.toColumnMap()).toList();
    }

    static Future<void> addProduct(Map<String, dynamic> product) async {
      await _connection.execute(
          'INSERT INTO products (name, category, sub_category, subcat2, flavor, description, cost_of_good, manufacturing_price, wholesale_price, retail_price, stock_quantity, backordered, supplier_id, manufacturer_id, manufacturer_name, item_source, quantity_sold, quantity_in_stock) VALUES (@name, @category, @subCategory, @subcat2, @flavor, @description, @costOfGood, @manufacturingPrice, @wholesalePrice, @retailPrice, @stockQuantity, @backordered, @supplierId, @manufacturerId, @manufacturerName, @itemSource, @quantitySold, @quantityInStock)',
          substitutionValues: {
            'name': product['name'],
            'category': product['category'],
            'subCategory': product['subCategory'],
            'subcat2': product['subcat2'],
            'flavor': product['flavor'],
            'description': product['description'],
            'costOfGood': product['costOfGood'],
            'manufacturingPrice': product['manufacturingPrice'],
            'wholesalePrice': product['wholesalePrice'],
            'retailPrice': product['retailPrice'],
            'stockQuantity': product['stockQuantity'],
            'backordered': product['backordered'],
            'supplierId': int.parse(product['supplier'].id),
            'manufacturerId': int.parse(product['manufacturerId']),
            'manufacturerName': product['manufacturerName'],
            'itemSource': product['itemSource'],
            'quantitySold': product['quantitySold'],
            'quantityInStock': product['quantityInStock'],
          });
    }
  }
}
