import 'package:flutter/cupertino.dart';
import 'contacts/contact_lists.dart';
import 'menu/menu.dart';
import 'menu/menu_item.dart';
import 'package:crafted_manager/menu/main_menu.dart'; // Add the missing semicolon
import 'package:crafted_manager/orders/order_list_screen.dart'; // Update the import path

void main() {
  runApp(const CraftedManager());
}

class CraftedManager extends StatelessWidget {
  const CraftedManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Crafted Manager',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: MenuView(),
    );
  }
}
