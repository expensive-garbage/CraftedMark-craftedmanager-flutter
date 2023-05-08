import 'package:flutter/cupertino.dart';
import 'package:crafted_manager/Models/product_model.dart';

class MenuItem {
  final String title;
  final IconData iconData;
  final Widget? destination;
  final List<MenuItem>? subItems;
  final List<Product>? products;
  bool isExpanded;

  MenuItem({
    required this.title,
    required this.iconData,
    this.destination,
    this.subItems,
    this.products,
    this.isExpanded = false,
  });
}
