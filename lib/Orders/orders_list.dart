import 'package:crafted_manager/postgres.dart';
import 'package:flutter/cupertino.dart';
import 'package:crafted_manager/orders/database_functions.dart';
import 'package:crafted_manager/orders/order_detail_widget.dart';
import 'package:crafted_manager/orders/create_order.dart'; // Add this line


class OrdersList extends StatefulWidget {
  const OrdersList({Key? key, required String title}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  Future<List<Map<String, dynamic>>> fetchAllOrders() async {
    print('Connecting to PostgreSQL...');
    try {
      print('Connected! Fetching orders...');
      final orders = await postgre.mappedResultsQuery("""
      SELECT o.order_id, p.firstname AS firstname, p.lastname AS lastname, o.total_amount AS total_amount
      FROM orders o
      JOIN people p ON o.people_id = p.id
      ORDER BY o.order_id DESC
    """);
      print('Fetched orders: $orders');
      return orders;
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Orders'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CreateOrder(),
              ),
            );
          },
          child: Icon(
            CupertinoIcons.add,
            size: 28,
          ),
        ),
      ),

      child: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchAllOrders(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              final orders = snapshot.data!;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  final order = orders[index];
                  final people = order['people'];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: CupertinoColors.systemGrey4),
                      ),
                    ),
                    child: CupertinoListTile(
                      title: Text('${people['firstname'] ?? ''} ${people['lastname'] ?? ''}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total: \$${order['orders']['total_amount']}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => OrderDetails(orderId: order['orders']['order_id']),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class OrderDetail extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Order Detail'),
        previousPageTitle: 'Orders',
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${widget.order['firstname']} ${widget.order['lastname']}'),
              Text('Total Amount: \$${widget.order['total_amount']}'),
              // Add other order details here
            ],
          ),
        ),
      ),
    );
  }
}
