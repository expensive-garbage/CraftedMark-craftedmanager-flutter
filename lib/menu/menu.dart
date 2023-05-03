import 'package:crafted_manager/Products/product_page.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/orders/order_list_screen.dart';
import 'package:crafted_manager/contacts/contact_lists.dart';
import 'package:crafted_manager/menu/PlaceHolderScreen.dart';
import 'package:crafted_manager/Products/postgres_product.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu_item.dart';
import 'menu_item_widget.dart';

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
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];

                    // Replace this with your custom product menu item widget
                    final List<MenuItem> menuItems = [  MenuItem(    title: "Dashboard",    iconData: CupertinoIcons.speedometer,    destination: PlaceholderScreen(title: 'Dashboard'),  ),  MenuItem(    title: "Production",    iconData: CupertinoIcons.gear_alt_fill,    subItems: [      MenuItem(        title: "Production Schedule",        iconData: CupertinoIcons.calendar,        destination: PlaceholderScreen(title: 'Production Schedule'),      ),      MenuItem(        title: "Production Reports",        iconData: CupertinoIcons.doc_text_fill,        destination: PlaceholderScreen(title: 'Production Reports'),      ),    ],
                    ),
                      MenuItem(
                        title: "Orders/Invoicing",
                        iconData: CupertinoIcons.cart_fill,
                        subItems: [
                          MenuItem(
                            title: "Invoices",
                            iconData: CupertinoIcons.calendar,
                            destination: PlaceholderScreen(title: 'Invoices'),
                          ),
                          MenuItem(
                            title: "Open Orders",
                            iconData: CupertinoIcons.doc_text_fill,
                            destination: OrdersListScreen(),
                          ),
                        ],
                      ),
                      MenuItem(
                        title: "Payments",
                        iconData: CupertinoIcons.creditcard_fill,
                        destination: PlaceholderScreen(title: 'Payments'),
                      ),
                      MenuItem(
                        title: "Contacts",
                        iconData: CupertinoIcons.person_2_fill,
                        destination: ContactsList(),
                        subItems: [
                          MenuItem(
                            title: "Customers",
                            iconData: CupertinoIcons.person_crop_circle_fill,
                            destination: PlaceholderScreen(title: 'Customers'),
                          ),
                          MenuItem(
                            title: "Suppliers",
                            iconData: CupertinoIcons.car_fill,
                            destination: PlaceholderScreen(title: 'Suppliers'),
                          ),
                          MenuItem(
                            title: "Vendors",
                            iconData: CupertinoIcons.building_2_fill,
                            destination: PlaceholderScreen(title: 'Vendors'),
                          ),
                        ],
                      ),
                      MenuItem(
                        title: "Products",
                        iconData: CupertinoIcons.cube_box_fill,
                        destination: ProductList(
                          onProductTap: (product) {},
                          products: menuItem.products?.whereType<Product>().toList() ?? [],
                        ),
                        subItems: [
                          MenuItem(
                            title: "Ingredient Inventory",
                            iconData: CupertinoIcons.clear_fill,
                          ),
                          MenuItem(
                            title: "Packaging Inventory",
                            iconData: CupertinoIcons.shift_fill,
                          ),
                        ],
                      ),
                      MenuItem(
                        title: "Accounting",
                        iconData: CupertinoIcons.chart_pie_fill,
                      ),
                      MenuItem(
                        title: "Employee",
                        iconData: CupertinoIcons.person_crop_circle,
                      ),
                    ];
                    // Replace this with your custom product menu item widget
                    return MenuItemWidget(
                      item: MenuItem(
                        title: product.name,
                        iconData: Icons.restaurant, // Add an IconData value here
                      ),
                      onTap: () => onMenuItemSelected(product),
                      destination: ProductList(
                        onProductTap: (product) {},
                        products: products?.where((p) => p != null).cast<Product>()?.toList() ?? [],
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
