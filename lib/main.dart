import 'package:flutter/cupertino.dart';
import 'contacts/contact_lists.dart';
import 'inventory/inventory_list.dart';
import 'sales/orders.dart';
import 'menu/menu.dart';

void main() {
  runApp(const CraftedManager());
}

class CraftedManager extends StatelessWidget {
  const CraftedManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Crafted Manager',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: MenuView(),
    );
  }
}
