import 'dart:async';
import 'dart:convert';
import 'dart:math';

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
    print('Adding product: ${product.name}');
    final connection = await _createConnection();
    try {
      await connection.execute(
        'INSERT INTO products (product_name, category, sub_category, subcat2, flavor, description, cost_of_good, manufacturing_price, wholesale_price, retail_price, stock_quantity, backordered, manufacturer_name, supplier_name, item_source, quantity_sold, quantity_in_stock) VALUES (@product_name, @category, @sub_category, @subcat2, @flavor, @description, @cost_of_good, @manufacturing_price, @wholesale_price, @retail_price, @stock_quantity, @backordered, @manufacturer_name, @supplier_name, @item_source, @quantity_sold, @quantity_in_stock)',
        substitutionValues: {
          //'product_id': product.id,
          'product_name': product.name,
          'category': product.category,
          'sub_category': product.subCategory,
          'subcat2': product.subcat2,
          'flavor': product.flavor,
          'description': product.description,
          'cost_of_good': product.costOfGood,
          'manufacturing_price': product.manufacturingPrice,
          'wholesale_price': product.wholesalePrice,
          'retail_price': product.retailPrice,
          'stock_quantity': product.stockQuantity,
          'backordered': product.backordered,
          'manufacturer_name': product.manufacturerName,
          'supplier_name': product.supplier,
          'item_source': product.itemSource,
          'quantity_sold': product.quantitySold,
          'quantity_in_stock': product.quantityInStock,
        },
      );
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
    } finally {
      await closeConnection(connection);
    }
  }

  // Generate a random UUID
  static String _generateUuid() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    return base64Url.encode(values).replaceAll('+', '-').replaceAll('/', '_');
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
      'UPDATE products SET product_name = @product_name, category = @category, sub_category = @sub_category, subcat2 = @subcat2, flavor = @flavor, description = @description, cost_of_good = @cost_of_good, manufacturing_price = @manufacturing_price, wholesale_price = @wholesale_price, retail_price = @retail_price, stock_quantity = @stock_quantity, backordered = @backordered, manufacturer_name = @manufacturer_name, supplier_name = @supplier_name, item_source = @item_source, quantity_sold = @quantity_sold, quantity_in_stock = @quantity_in_stock WHERE product_id = @product_id',
      substitutionValues: {
        'product_id': product.id,
        'product_name': product.name,
        'category': product.category,
        'sub_category': product.subCategory,
        'subcat2': product.subcat2,
        'flavor': product.flavor,
        'description': product.description,
        'cost_of_good': product.costOfGood,
        'manufacturing_price': product.manufacturingPrice,
        'wholesale_price': product.wholesalePrice,
        'retail_price': product.retailPrice,
        'stock_quantity': product.stockQuantity,
        'backordered': product.backordered,
        'manufacturer_name': product.manufacturerName,
        'supplier_name': product.supplier,
        'item_source': product.itemSource,
        'quantity_sold': product.quantitySold,
        'quantity_in_stock': product.quantityInStock,
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
