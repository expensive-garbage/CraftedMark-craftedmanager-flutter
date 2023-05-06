import 'package:crafted_manager/Models/product_model.dart';
import '../Products/postgres_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu_item.dart';
import 'menu_item_widget.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

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
                      onTap: () {
                        // Handle menu item selection
                      },
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
