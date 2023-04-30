import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/Models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(product.productName),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                product.description,
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
              SizedBox(height: 16.0),
              Text(
                'Price: ${product.price}',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
              SizedBox(height: 16.0),
              Text(
                'Stock quantity: ${product.stockQuantity}',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
