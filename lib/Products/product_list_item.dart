import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/Models/product_model.dart';

class ProductListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Product product;
  final VoidCallback onTap;

  const ProductListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text('ID: ${product.id.toString()}'),
      ),
    );
  }
}
