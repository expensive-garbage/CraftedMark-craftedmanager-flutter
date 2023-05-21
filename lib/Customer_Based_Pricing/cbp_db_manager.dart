import 'dart:async';

import 'package:crafted_manager/postgres.dart';

class CustomerBasedPricingDbManager {
  static final CustomerBasedPricingDbManager instance =
      CustomerBasedPricingDbManager._privateConstructor();

  CustomerBasedPricingDbManager._privateConstructor();

  // Get all records from the specified table
  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    return await fetchData(tableName);
  }

  // Search records in the specified table using search query and substitution values
  Future<List<Map<String, dynamic>>> search(String tableName,
      String searchQuery, Map<String, dynamic> substitutionValues) async {
    return await searchData(tableName, searchQuery, substitutionValues);
  }

// Add a record to the specified table

  Future<void> add(String tableName, Map<String, dynamic> data) async {
    await add(tableName, data);
  }

  // Update a record in the specified table with the provided updated data
  Future<void> update(
      String tableName, int id, Map<String, dynamic> updatedData) async {
    await update(tableName, id, updatedData);
  }

  // Delete a record from the specified table with the provided id
  Future<void> delete(String tableName, int id) async {
    await delete(tableName, id);
  }

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

  // Get pricing list based on customer id
  Future<Map<String, dynamic>?> getPricingListByCustomerId(
      int customerId) async {
    final customerData =
        await search('people', 'id = @customerId', {'customerId': customerId});
    if (customerData.isNotEmpty) {
      int pricingListId = customerData[0]['assigned_pricing_list_id'];
      final pricingListData = await search('customer_pricing_lists',
          'id = @pricingListId', {'pricingListId': pricingListId});
      return pricingListData.isNotEmpty ? pricingListData[0] : null;
    }
    return null;
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
