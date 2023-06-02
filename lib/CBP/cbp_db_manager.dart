import 'dart:async';

import 'package:postgres/postgres.dart';

class CustomerBasedPricingDbManager {
  static final CustomerBasedPricingDbManager instance =
      CustomerBasedPricingDbManager._privateConstructor();

  CustomerBasedPricingDbManager._privateConstructor();

  static Future<PostgreSQLConnection> openConnection() async {
    print('Opening connection...');
    final connection = PostgreSQLConnection(
      'web.craftedsolutions.co', // Database host
      5432, // Port number
      'craftedmanager_db', // Database name
      username: 'craftedmanager_dbuser', // Database username
      password: '!!Laganga1983', // Database password
    );
    await connection.open();
    print('Connection opened');
    return connection;
  }

  static Future<void> closeConnection(PostgreSQLConnection connection) async {
    print('Closing connection...');
    await connection.close();
    print('Connection closed');
  }

  // CRUD Methods

  // Get all records from the specified table
  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    final connection = await openConnection();
    final result = await connection.query('SELECT * FROM $tableName');
    await closeConnection(connection);
    return result.map((row) => row.toTableColumnMap()).toList();
  }

  // Add a record to the specified table
  Future<void> add(String tableName, Map<String, dynamic> data) async {
    final connection = await openConnection();
    final columns = data.keys.join(', ');
    final values = data.keys.map((key) => '@${key}').join(', ');
    await connection.execute(
      'INSERT INTO $tableName ($columns) VALUES ($values)',
      substitutionValues: data,
    );
    await closeConnection(connection);
  }

  // Update a record in the specified table with the provided updated data
  Future<void> update(
      String tableName, int id, Map<String, dynamic> updatedData) async {
    final connection = await openConnection();
    final updates = updatedData.keys.map((key) => '$key = @${key}').join(', ');
    await connection.execute(
      'UPDATE $tableName SET $updates WHERE id = @id',
      substitutionValues: {'id': id, ...updatedData},
    );
    await closeConnection(connection);
  }

  // Delete a record from the specified table with the provided id
  Future<void> delete(String tableName, int id) async {
    final connection = await openConnection();
    await connection.execute(
      'DELETE FROM $tableName WHERE id = @id',
      substitutionValues: {'id': id},
    );
    await closeConnection(connection);
  }

  // Search records in the specified table using search query and substitution values
  // Search records in the specified table using search query and substitution values
  Future<List<Map<String, dynamic>>> search(String tableName,
      String searchQuery, Map<String, dynamic> substitutionValues) async {
    final connection = await openConnection();
    final result = await connection.query(
      'SELECT * FROM $tableName WHERE $searchQuery',
      substitutionValues: substitutionValues,
    );
    await closeConnection(connection);
    return result.map((row) => row.toTableColumnMap()).toList();
  }

  Future<List<Map<String, dynamic>>> searchProductsByName(
      String keyword) async {
    final searchResults = await CustomerBasedPricingDbManager.instance.search(
      'products',
      'name ILIKE @keyword',
      {'keyword': '%$keyword%'},
    );
    return searchResults;
  }

  // Search records in the specified table using search query and substitution values
  Future<List<Map<String, dynamic>>> searchProducts(
      String searchQuery, Map<String, dynamic> substitutionValues) async {
    final connection = await openConnection();
    final result = await connection.query(
      'SELECT * FROM products WHERE $searchQuery',
      substitutionValues: substitutionValues,
    );
    await closeConnection(connection);
    return result.map((row) => row.toTableColumnMap()).toList();
  }

  // Customer Pricing List methods

  // Get all pricing lists
  Future<List<Map<String, dynamic>>> getAllPricingLists() {
    return getAll('customer_pricing_lists');
  }

  // Add a pricing list
  Future<void> addPricingList(Map<String, dynamic> data) {
    return add('customer_pricing_lists', data);
  }

  // Update a pricing list
  Future<void> updatePricingList(int id, Map<String, dynamic> updatedData) {
    return update('customer_pricing_lists', id, updatedData);
  }

  // Delete a pricing list
  Future<void> deletePricingList(int id) {
    return delete('customer_pricing_lists', id);
  }

  // Customer Product Pricing methods

  // Get all customer-product pricing
  Future<List<Map<String, dynamic>>> getAllCustomerProductPricing() {
    return getAll('customer_product_pricing');
  }

  // Add a customer-product pricing
  Future<void> addCustomerProductPricing(Map<String, dynamic> data) {
    return add('customer_product_pricing', data);
  }

  // Update a customer-product pricing
  Future<void> updateCustomerProductPricing(
      int id, Map<String, dynamic> updatedData) {
    return update('customer_product_pricing', id, updatedData);
  }

  // Delete a customer-product pricing
  Future<void> deleteCustomerProductPricing(int id) {
    return delete('customer_product_pricing', id);
  }

  // Add or update customer product pricing
  Future<void> addOrUpdateCustomerProductPricing({
    required int productId,
    required int customerId,
    required double price,
  }) async {
    int? pricingListId = await getPricingListIdByCustomerId(customerId);

    if (pricingListId == null) {
      // Add code to create a new pricing list for the customer if it doesn't exist.
      // You can use the addPricingList method to create a new pricing list.
      // Then, update the customer's assigned_pricing_list_id with the new pricing list id.
    }

    // Check if a custom price already exists for the product and customer.
    var result = await search(
      'customer_product_pricing',
      'product_id = @productId AND customer_pricing_list_id = @pricingListId',
      {
        'productId': productId,
        'pricingListId': pricingListId,
      },
    );

    if (result.isNotEmpty) {
      // Update the existing custom price.
      await update(
        'customer_product_pricing',
        result[0]['id'],
        {'price': price},
      );
    } else {
      // Add a new custom price for the product and customer.
      await addCustomerProductPricing(
        {
          'product_id': productId,
          'customer_pricing_list_id': pricingListId,
          'price': price,
        },
      );
    }
  }

  // Get pricing list id by customer id
  Future<int?> getPricingListIdByCustomerId(int customerId) async {
    final pricingListData =
        await search('customer_pricing_lists', 'customer_id = @customerId', {
      'customerId': customerId,
    });
    return pricingListData.isNotEmpty ? pricingListData[0]['id'] : null;
  }

  // Get pricing list by customer id
  Future<int?> getPricingListByCustomerId(int customerId) async {
    final pricingListData =
        await search('customer_pricing_lists', 'customer_id = @customerId', {
      'customerId': customerId,
    });
    return pricingListData.isNotEmpty ? pricingListData[0]['id'] : null;
  }

  // Fetch customer based pricing for a specific customer
  Future<List<Map<String, dynamic>>> fetchCustomerBasedPricing(
      int customerId) async {
    final connection = await openConnection();
    final PostgreSQLResult result = await connection.query(
      '''
    SELECT
      p.id as product_id,
      p.name as product_name,
      p.price as original_price,
      cpp.price as custom_price
    FROM
      products p
    LEFT JOIN customer_product_pricing cpp ON p.id = cpp.product_id
    LEFT JOIN customer_pricing_lists cpl ON cpl.id = cpp.customer_pricing_list_id
    LEFT JOIN people cust ON cust.assigned_pricing_list_id = cpl.id
    WHERE
      cust.id = @customerId
    ''',
      substitutionValues: {'customerId': customerId},
    );
    final List<Map<String, dynamic>> results = result
        .map((row) => {
              'product_id': row[0],
              'product_name': row[1],
              'original_price': row[2],
              'custom_price': row[3],
            })
        .toList();
    await closeConnection(connection);
    return results;
  }

  // Get customer product pricing by product id and pricing list id
  Future<Map<String, dynamic>?> getCustomerProductPricing(
      int productId, int pricingListId) async {
    final pricingData = await search(
        'customer_product_pricing',
        'product_id = @productId AND customer_pricing_list_id = @pricingListId',
        {
          'productId': productId,
          'pricingListId': pricingListId,
        });
    return pricingData.isNotEmpty ? pricingData[0] : null;
  }
}
