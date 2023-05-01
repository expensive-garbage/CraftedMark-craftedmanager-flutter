import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/postgres.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'product_list_item.dart';
import 'product_detail.dart';
import 'edit_product.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductList> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    List<Map<String, dynamic>>? fetchedData = await fetchData('products');
    if (fetchedData != null) {
      setState(() {
        products = fetchedData.map((data) => Product.fromMap(data)).toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Products'),
      ),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('${product.price} - ${product.supplier.name}'),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => EditProductPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}