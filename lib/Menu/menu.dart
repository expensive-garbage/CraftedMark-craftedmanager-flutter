import 'package:crafted_manager/contacts/contact_lists.dart';
import 'package:flutter/cupertino.dart';

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
    MenuItem(title: "Dashboard", iconData: CupertinoIcons.speedometer),
    MenuItem(
        title: "Production",
        iconData: CupertinoIcons.gear_alt_fill,
        subItems: [
          MenuItem(
              title: "Production Schedule", iconData: CupertinoIcons.calendar),
          MenuItem(
              title: "Production Reports",
              iconData: CupertinoIcons.doc_text_fill),
        ]),
    MenuItem(
        title: "Orders/Invoicing",
        iconData: CupertinoIcons.cart_fill,
        subItems: [
          MenuItem(title: "Invoices", iconData: CupertinoIcons.calendar),
          MenuItem(
              title: "Open Orders", iconData: CupertinoIcons.doc_text_fill),
        ]),
    MenuItem(title: "Payments", iconData: CupertinoIcons.creditcard_fill),
    MenuItem(
        title: "Contacts",
        iconData: CupertinoIcons.person_2_fill,
        destination: const ContactsList(),
        subItems: [
          MenuItem(
              title: "Customers",
              iconData: CupertinoIcons.person_crop_circle_fill),
          MenuItem(title: "Suppliers", iconData: CupertinoIcons.car_fill),
          MenuItem(title: "Vendors", iconData: CupertinoIcons.building_2_fill),
        ]),
    MenuItem(
        title: "Inventory",
        iconData: CupertinoIcons.cube_box_fill,
        subItems: [
          MenuItem(
              title: "Ingredient Inventory",
              iconData: CupertinoIcons.clear_fill),
          MenuItem(
              title: "Packaging Inventory",
              iconData: CupertinoIcons.shift_fill),
        ]),
    MenuItem(title: "Accounting", iconData: CupertinoIcons.chart_pie_fill),
    MenuItem(title: "Employee", iconData: CupertinoIcons.person_crop_circle),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Crafted Manager'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                MenuItem menuItem = menuItems[index];
                return GestureDetector(
                  onTap: () => _onMenuItemSelected(menuItem),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Icon(menuItem.iconData),
                        const SizedBox(width: 10),
                        Text(menuItem.title),
                      ],
                    ),
                  ),
                );
              },
              childCount: menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
