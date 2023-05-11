import 'dart:async';

import 'package:crafted_manager/Models/product_model.dart';
import 'package:postgres/postgres.dart';

class ProductPostgres {
  static Future<PostgreSQLConnection> _createConnection() async {
    final connection = PostgreSQLConnection(
      'web.craftedsolutions.co', // Database host
      5432, // Port number
      'craftedmanager_db', // Database name
      username: 'craftedmanager_dbuser', // Database username
      password: '!!Laganga1983', // Database password
    );
    await connection.open();
    return connection;
  }

  static Future<void> closeConnection(PostgreSQLConnection connection) async {
    await connection.close();
  }

  static Future<void> addProduct(Product product) async {
    final connection = await _createConnection();
    await connection.execute(
      'INSERT INTO products (name, category, sub_category, subcat2, flavor, description, cost_of_good, manufacturing_price, wholesale_price, retail_price, stock_quantity, backordered, supplier_id, manufacturer_id, manufacturer_name, item_source, quantity_sold, quantity_in_stock) VALUES (@name, @category, @subCategory, @subcat2, @flavor, @description, @costOfGood, @manufacturingPrice, @wholesalePrice, @retailPrice, @stockQuantity, @backordered, @supplierId, @manufacturerId, @manufacturerName, @itemSource, @quantitySold, @quantityInStock)',
      substitutionValues: {
        'name': product.name,
        'category': product.category,
        'subCategory': product.subCategory,
        'subcat2': product.subcat2,
        'flavor': product.flavor,
        'description': product.description,
        'costOfGood': product.costOfGood,
        'manufacturingPrice': product.manufacturingPrice,
        'wholesalePrice': product.wholesalePrice,
        'retailPrice': product.retailPrice,
        'stockQuantity': product.stockQuantity,
        'backordered': product.backordered,
        'supplierId': product.supplierId,
        'manufacturerId': product.manufacturerId,
        'manufacturerName': product.manufacturerName,
        'itemSource': product.itemSource,
        'quantitySold': product.quantitySold,
        'quantityInStock': product.quantityInStock,
      },
    );
    await closeConnection(connection);
  }

  static Future<List<Product>> getAllProducts() async {
    final connection = await _createConnection();
    final results = await connection.query('SELECT * FROM products');
    await closeConnection(connection);
    return results.map((row) => Product.fromMap(row.toColumnMap())).toList();
  }

  static Future<void> updateProduct(Product product) async {
    final connection = await _createConnection();
    await connection.execute(
      'UPDATE products SET name = @name, category = @category, sub_category = @subCategory, subcat2 = @subcat2, flavor = @flavor, description = @description, cost_of_good = @costOfGood, manufacturing_price = @manufacturingPrice, wholesale_price = @wholesalePrice, retail_price = @retailPrice, stock_quantity = @stockQuantity, backordered = @backordered, supplier_id = @supplierId, manufacturer_id = @manufacturerId, manufacturer_name = @manufacturerName, item_source = @itemSource, quantity_sold = @quantitySold, quantity_in_stock = @quantityInStock WHERE id = @id',
      substitutionValues: {
        'id': product.id,
        'name': product.name,
        'category': product.category,
        'subCategory': product.subCategory,
        'subcat2': product.subcat2,
        'flavor': product.flavor,
        'description': product.description,
        'costOfGood': product.costOfGood,
        'manufacturingPrice': product.manufacturingPrice,
        'wholesalePrice': product.wholesalePrice,
        'retailPrice': product.retailPrice,
        'stockQuantity': product.stockQuantity,
        'backordered': product.backordered,
        'supplierId': product.supplierId,
        'manufacturerId': product.manufacturerId,
        'manufacturerName': product.manufacturerName,
        'itemSource': product.itemSource,
        'quantitySold': product.quantitySold,
        'quantityInStock': product.quantityInStock,
      },
    );
    await closeConnection(connection);
  }

  static Future<void> deleteProduct(int id) async {
    final connection = await _createConnection();
    await connection.execute(
      'DELETE FROM products WHERE id = @id',
      substitutionValues: {
        'id': id,
      },
    );
    await closeConnection(connection);
  }

  static Future<List<Product>> searchProducts(String keyword) async {
    final connection = await _createConnection();
    final results = await connection.query(
      'SELECT * FROM products WHERE name ILIKE @keyword OR description ILIKE @keyword',
      substitutionValues: {'keyword': '%$keyword%'},
    );
    await closeConnection(connection);
    return results.map((row) => Product.fromMap(row.toColumnMap())).toList();
  }
}
