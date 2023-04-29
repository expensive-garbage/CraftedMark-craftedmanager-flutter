import 'package:flutter/cupertino.dart';
import 'menu/menu.dart'; // Import the ParentView widget

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
      home: MenuView(), // Use ParentView as the home widget
    );
  }
}
