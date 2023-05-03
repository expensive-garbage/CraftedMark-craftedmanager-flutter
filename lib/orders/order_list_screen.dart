import 'package:flutter/cupertino.dart';
import 'package:crafted_manager/Models/order_model.dart';
import 'package:flutter/material.dart';


class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  List<Order> orders = []; // You'll need to replace this with real data from your database

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Open Orders'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            // Navigate to Add Order Screen
          },
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            Order order = orders[index];
            return ListTile(
              title: Text('Order #${order.id} - ${order.customerId}'),
              subtitle: Text('${order.orderDate} - \$${order.totalAmount}'),
              onTap: () {
                // Navigate to Order Details Screen
              },
            );
          },
        ),
      ),
    );
  }
}
