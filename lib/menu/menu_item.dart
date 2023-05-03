import 'package:flutter/cupertino.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'menu.dart';
import 'package:crafted_manager/Products/product_page.dart';

class MenuItem {
  final String title;
  final IconData iconData;
  final Widget? destination;
  final List<MenuItem>? subItems;
  final List<Product>? products;
  bool _isExpanded;

  MenuItem({
    required this.title,
    required this.iconData,
    this.destination,
    this.subItems,
    this.products,
    bool isExpanded = false,
  }) : _isExpanded = isExpanded;

  bool get isExpanded => _isExpanded;
  set isExpanded(bool value) {
    _isExpanded = value;
  }
}
