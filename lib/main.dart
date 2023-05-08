import 'package:crafted_manager/menu/menu.dart';
import 'package:flutter/cupertino.dart';

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
          //onMenuItemSelected: (Product product) {
          // Handle menu item selection here
          // },
          ),
    );
  }
}
