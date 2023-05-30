import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:crafted_manager/menu/menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenuWidget extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onTap;

  const MainMenuWidget({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.iconData),
      title: Text(item.title),
      onTap: onTap,
    );
  }
}

class MainMenu extends StatelessWidget {
  final Function(Product) onMenuItemSelected;

  const MainMenu({
    Key? key,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.black,
      body: Builder(builder: (context) {
        return CupertinoScrollbar(
          child: FutureBuilder<List<Product>>(
            future: ProductPostgres.getAllProductsExceptIngredients(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final products = snapshot.data;
                if (products != null) {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];

                      return MainMenuWidget(
                        item: MenuItem(
                          title: product.name,
                          iconData: Icons.arrow_right,
                          destination: Text('Placeholder'),//TODO:FIX
                        ),
                        onTap: () => onMenuItemSelected(product),
                      );
                    },
                  );
                } else {
                  return const Text('No products available');
                }
              }
            },
          ),
        );
      }),
    );
  }
}
