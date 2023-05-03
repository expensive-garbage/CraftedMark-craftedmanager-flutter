import 'package:crafted_manager/postgres.dart';
import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';
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
    print('Connected to PostgreSQL');
  }

  static Future<void> closeConnection() async {
    await _connection.close();
    print('Closed connection to PostgreSQL');
  }

  static Future<List<Product>> getAllProducts() async {
    final results = await _connection.query('SELECT * FROM products');
    return results.map((row) => Product.fromMap(row.toColumnMap())).toList();
  }


  static Future<List<Map<String, dynamic>>> searchProducts(String keyword) async {
    final results = await _connection.query('SELECT * FROM products WHERE name ILIKE @keyword OR description ILIKE @keyword', substitutionValues: {'keyword': '%$keyword%'});
    return results;
  }

  static Future<void> addProduct(Map<String, dynamic> product) async {
    final result = await _connection.execute('INSERT INTO products (name, category, sub_category, subcat2, flavor, description, cost_of_good, manufacturing_price, wholesale_price, retail_price, stock_quantity, backordered, supplier_id, manufacturer_id, manufacturer_name, item_source, quantity_sold, quantity_in_stock) VALUES (@name, @category, @subCategory, @subcat2, @flavor, @description, @costOfGood, @manufacturingPrice, @wholesalePrice, @retailPrice, @stockQuantity, @backordered, @supplierId, @manufacturerId, @manufacturerName, @itemSource, @quantitySold, @quantityInStock)', substitutionValues: {
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
      'supplierId': product['supplier'].id,
      'manufacturerId': product['manufacturerId'],
      'manufacturerName': product['manufacturerName'],
      'itemSource': product['itemSource'],
      'quantitySold': product['quantitySold'],
      'quantityInStock': product['quantityInStock'],
    });
    print('Added product to database: $product');
  }
static Future<void> updateProduct(int id, Map<String, dynamic> updatedProduct) async {
  final result = await _connection.execute('UPDATE products SET name = @name, category = @category, sub_category = @subCategory, subcat2 = @subcat2, flavor = @flavor, description = @description, cost_of_good = @costOfGood, manufacturing_price = @manufacturingPrice, wholesale_price = @wholesalePrice, retail_price = @retailPrice, stock_quantity = @stockQuantity, backordered = @backordered, supplier_id = @supplierId, manufacturer_id = @manufacturerId, manufacturer_name = @manufacturerName, item_source = @itemSource, quantity_sold = @quantitySold, quantity_in_stock = @quantityInStock WHERE id = @id', substitutionValues: {
    'id': id,
    'name': updatedProduct['name'],
    'category': updatedProduct['category'],
    'subCategory': updatedProduct['subCategory'],
    'subcat2': updatedProduct['subcat2'],
    'flavor': updatedProduct['flavor'],
    'description': updatedProduct['description'],
    'costOfGood': updatedProduct['costOfGood'],
    'manufacturingPrice': updatedProduct['manufacturingPrice'],
    'wholesalePrice': updatedProduct['wholesalePrice'],
    'retailPrice': updatedProduct['retailPrice'],
    'stockQuantity': updatedProduct['stockQuantity'],
    'backordered': updatedProduct['backordered'],
    'supplierId': updatedProduct['supplier'].id,
    'manufacturerId': updatedProduct['manufacturerId'],
    'manufacturerName': updatedProduct['manufacturerName'],
    'itemSource': updatedProduct['itemSource'],
    'quantitySold': updatedProduct['quantitySold'],
    'quantityInStock': updatedProduct['quantityInStock'],
  });
  if (result == 0) {
    throw Exception('Product with id $id not found');
  }
  print('Updated product in database with id $id: $updatedProduct');
}

static Future<void> deleteProduct(String id) async {
  final result = await _connection.execute('DELETE FROM products WHERE id = @id', substitutionValues: {'id': id});
  if (result == 0) {
    throw Exception('Product with id $id not found');
  }
  print('Deleted product from database with id $id');
}
}
