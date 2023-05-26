import 'package:crafted_manager/Assembly_Items/assembly_Item_list.dart';
import 'package:crafted_manager/Customer_Based_Pricing/customer_based_pricing_screen.dart';
import 'package:crafted_manager/Orders/orders_list.dart';
import 'package:crafted_manager/Products/product_page.dart';
import 'package:crafted_manager/contacts/contact_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu_item.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  MenuViewState createState() => MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  void initState() {
    super.initState();
  }

  void _onMenuItemSelected(MenuItem menuItem) {
    if (menuItem.destination != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => menuItem.destination!),
      );
    }
  }

  final List<MenuItem> menuItems = [
    MenuItem(
        title: "Orders/Invoicing",
        iconData: CupertinoIcons.cart_fill,
        subItems: [
          MenuItem(
              title: "Open Orders",
              iconData: CupertinoIcons.doc_text_fill,
              destination: const OrdersList(title: "Orders")),
          MenuItem(
              title: "Invoices",
              iconData: CupertinoIcons.money_dollar,
              destination: const OrdersList(title: "Invoices"))
        ]),
    MenuItem(
        title: "Contacts",
        iconData: CupertinoIcons.person_2_fill,
        subItems: [
          MenuItem(
            title: "Customers",
            iconData: CupertinoIcons.person_crop_circle_fill,
            destination: const ContactsList(),
          ),
        ]),
    MenuItem(
        title: "Product Management",
        iconData: CupertinoIcons.cube_box_fill,
        subItems: [
          MenuItem(
              title: "Products",
              iconData: CupertinoIcons.cube_box,
              destination: ProductListPage()),
          MenuItem(
              title: "Customer Based Pricing",
              iconData: CupertinoIcons.money_dollar_circle_fill,
              destination: CustomerBasedPricingScreen()),
          MenuItem(
              title: "Assembly Items",
              iconData: CupertinoIcons.money_dollar_circle_fill,
              destination: AssemblyItemManagement()) // New menu item added.
        ]),
    // Add more menu items/categories here if needed.
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            largeTitle:
                Text('Crafted Manager', style: TextStyle(color: Colors.white)),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                MenuItem menuItem = menuItems[index];
                return menuItem.subItems == null
                    ? CupertinoListTile(
                        leading: Icon(menuItem.iconData, color: Colors.white),
                        title: Text(menuItem.title,
                            style: const TextStyle(color: Colors.white)),
                        onTap: () => _onMenuItemSelected(menuItem))
                    : Material(
                        color: Color.fromARGB(255, 0, 0, 0),
                        child: ExpansionTile(
                          leading: Icon(menuItem.iconData, color: Colors.white),
                          title: Text(menuItem.title,
                              style: const TextStyle(color: Colors.white)),
                          children: menuItem.subItems!
                              .map((subItem) => CupertinoListTile(
                                    leading: Icon(subItem.iconData,
                                        color: Colors.white),
                                    title: Text(subItem.title,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                    onTap: () => _onMenuItemSelected(subItem),
                                  ))
                              .toList(),
                        ));
              },
              childCount: menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
