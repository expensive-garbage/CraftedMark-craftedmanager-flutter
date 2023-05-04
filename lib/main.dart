import 'package:flutter/cupertino.dart';
import 'menu/menu.dart';
// Add the missing semicolon
// Update the import path

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
      home: MenuView(),
    );
  }
}
