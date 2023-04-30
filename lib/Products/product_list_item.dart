import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'package:crafted_manager/Models/product_model.dart';

class ProductListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final Products product;

  ProductListItem({required this.title, required this.subtitle, required this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
      ),
    );
  }
}
