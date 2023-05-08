import 'dart:convert';

import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/menu/main_menu.dart';
import 'package:crafted_manager/orders/database_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // This line is required for async operations in main.

  await fetchAndStoreAllSchemas();
  await _loadAllSchemas();

  runApp(const CraftedManager());
}

Future<void> _loadAllSchemas() async {
  final preferences = await SharedPreferences.getInstance();
  final jsonString = preferences.getString('all_schemas');
  if (jsonString != null) {
    Map<String, List<Map<String, dynamic>>> _schemas = jsonDecode(jsonString);
    // You can use _schemas as needed or store it somewhere else.
  }
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
