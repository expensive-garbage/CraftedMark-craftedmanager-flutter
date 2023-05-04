import 'package:crafted_manager/Products/product_page.dart';
import 'package:crafted_manager/Models/product_model.dart';
import '../Products/postgres_product.dart' show ProductPostgres;
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu_item.dart';
import 'menu_item_widget.dart';
import 'package:crafted_manager/menu/menu_item.dart';
import 'package:crafted_manager/menu/menu.dart';

class MainMenu extends StatelessWidget {
  final Function(Product) onMenuItemSelected;
  final List<Product> products;

  const MainMenu({
    Key? key,
    required this.onMenuItemSelected,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Menu'),
      ),
      child: Builder(builder: (context) {
        return CupertinoScrollbar(
          child: FutureBuilder<List<Product>>(
            future: ProductPostgres.getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];

                    return MenuItemWidget(
                      item: MenuItem(
                        title: product.name,
                        iconData: Icons.restaurant,
                      ),
                      onTap: () => onMenuItemSelected(product),
                      destination: ProductList(
                        onProductTap: (product) {},
                        products: products.where((p) => p != null).cast<Product>().toList(),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      }),
    );
  }
}

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainMenu(
      onMenuItemSelected: (product) {
        // Handle menu item selection
      },
    );
  }
}
