import 'package:flutter/cupertino.dart' show IconData, Widget;

class MenuItem {
  final String title;
  final IconData iconData;
  final List<MenuItem> subItems;
  final Widget? destination;
  bool isExpanded;

  MenuItem({
    required this.title,
    required this.iconData,
    this.subItems = const [],
    this.destination,
    this.isExpanded = false,
  });
}
