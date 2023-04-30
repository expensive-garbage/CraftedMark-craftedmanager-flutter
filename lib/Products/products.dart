import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/postgres.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'product_list_item.dart'; // Import the ProductListItem widget
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Products> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final productsData = await fetchData('products');
    setState(() {
      _searchResults = productsData.map((row) => Products.fromJson(row)).toList();
    });
  }

  Future<void> _searchProducts(String searchQuery) async {
    final results = await searchData('products', 'product_name ILIKE @searchQuery OR description ILIKE @searchQuery', {'searchQuery': '%$searchQuery%'});
    setState(() {
      _searchResults = results.map((row) => Products.fromJson(row)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoTextField(
          controller: _searchController,
          placeholder: 'Search products',
          onSubmitted: _searchProducts,
        ),
      ),
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return ProductListItem(
            title: product.productName, // Use product.productName instead of product['product_name']
            subtitle: product.description, // Use product.description instead of product['description']
            product: product,
            onTap: () {
              // Do something with the tapped product
            },
          );
        },
      ),
    );
  }
}
