import 'package:flutter/cupertino.dart';
import 'package:crafted_manager/menu/main_menu.dart';
import 'package:crafted_manager/Models/product_model.dart';

void main() {
  runApp(const CraftedManager());
}

class CraftedManager extends StatelessWidget {
  const CraftedManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Crafted Manager',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: MainMenu(
        onMenuItemSelected: (Product product) {
          // Handle menu item selection here
        },
      ),
    );
  }
}
