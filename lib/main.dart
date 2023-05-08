import 'dart:convert';

import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/menu/menu.dart';
import 'package:crafted_manager/orders/database_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // This line is required for async operations in main.

  // await fetchAndStoreAllSchemas();
  // await _loadAllSchemas();

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
      home: MenuView(
      ),
    );
  }
}
