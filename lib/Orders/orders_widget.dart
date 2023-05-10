import 'package:crafted_manager/Orders/orders_db_manager.dart';
import 'package:crafted_manager/orders/create_order.dart'; // Add this line
import 'package:crafted_manager/orders/database_functions.dart';
import 'package:crafted_manager/orders/order_detail_widget.dart';
import 'package:crafted_manager/orders/orders_list.dart'; // Import the fetchAllOrders function
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(orders),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = orders[index];
                return CupertinoListTile(
                  title: Text(order['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: \$${order['total_amount']}'),
                      Text('Total Due: \$${order['total_due']}'),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
