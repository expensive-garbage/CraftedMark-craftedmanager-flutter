import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  final People customer;
  final List<OrderedItem> orderedItems;

  const OrderDetailScreen({
    Key? key,
    required this.order,
    required this.customer,
    required this.orderedItems,
  }) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
