import 'package:crafted_manager/Contacts/people_db_manager.dart';
import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Orders/order_postgres.dart';
import 'package:crafted_manager/Orders/search_people_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Models/people_model.dart';
import '../Models/product_model.dart';
import 'order_detail_screen.dart';
import 'ordered_item_postgres.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key, required String title}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  Future<List<Map<String, dynamic>>>? _futureOrders;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    _futureOrders = OrderPostgres.fetchAllOrders();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshList();
    _refreshController.refreshCompleted();
  }

  Future<void> _refreshList() async {
    setState(() {
      _futureOrders = OrderPostgres.fetchAllOrders();
    });
  }

  Future<List<OrderedItem>> fetchOrderedItems(int orderId) async {
    return await OrderedItemPostgres.fetchOrderedItems(orderId);
  }

  Future<List<Product>> fetchProducts(List<OrderedItem> orderedItems) async {
    // Implement the logic to fetch the list of products from the database based on the orderedItems list
    return [];
  }

  Future<People?> _getCustomerById(int customerId) async {
    return await PeoplePostgres.fetchCustomer(customerId);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: const Text('Orders'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => SearchPeopleScreen(),
              ),
            ).then((value) => _onRefresh());
          },
          child: Icon(
            CupertinoIcons.add,
            size: 28,
          ),
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _futureOrders,
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              final orders = snapshot.data!;
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: _onRefresh,
                header: ClassicHeader(),
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    final order = Order.fromMap(orders[index]);
                    return FutureBuilder<People?>(
                      future: _getCustomerById(int.parse(order.customerId)),
                      builder: (BuildContext context,
                          AsyncSnapshot<People?> customerSnapshot) {
                        if (customerSnapshot.hasData) {
                          final customer = customerSnapshot.data!;
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: CupertinoColors.systemGrey4),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                List<OrderedItem> orderedItems =
                                    await fetchOrderedItems(order.id);
                                List<Product> products =
                                    await fetchProducts(orderedItems);

                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => OrderDetailScreen(
                                      order: order,
                                      customer: customer,
                                      orderedItems: orderedItems,
                                      products: products,
                                    ),
                                  ),
                                ).then((value) => _onRefresh());
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order ID: ${order.id}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Text(
                                        'Customer: ${customer.firstName} ${customer.lastName}'),
                                    Text('Total: \$${order.totalAmount}'),
                                    Text('Status: ${order.orderStatus}'),
                                    Text(
                                        'Order Date: ${DateFormat('MM-dd-yyyy').format(order.orderDate)}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (customerSnapshot.hasError) {
                          return Center(
                            child: Text('Error: ${customerSnapshot.error}'),
                          );
                        } else {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
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
