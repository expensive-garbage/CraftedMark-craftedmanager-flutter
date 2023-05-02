import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/models/product_model.dart';
import 'package:crafted_manager/Products/product_detail.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onProductTap;

  ProductList({required this.products, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Products'),
        trailing: CupertinoButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            // Implement add product functionality
          },
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => onProductTap(product),
              child: CupertinoContextMenu(
                actions: <Widget>[
                  // Add your context menu actions here, for example:
                  CupertinoContextMenuAction(
                    child: const Text('Edit'),
                    onPressed: () {
                      // Add your edit functionality here
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoContextMenuAction(
                    child: const Text('Delete'),
                    onPressed: () {
                      // Add your delete functionality here
                      Navigator.pop(context);
                    },
                  ),
                ],
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        product.description,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '\$${product.retailPrice}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
