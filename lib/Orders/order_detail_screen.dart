import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../Orders/edit_order_screen.dart';
import '../../Orders/orders_db_manager.dart';
import 'edit_order_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    Key? key,
    required this.order,
    required this.customer,
    required this.orderedItems,
    required this.products,
  }) : super(key: key);

  final People customer;
  final Order order;
  final List<OrderedItem> orderedItems;
  final List<Product> products;

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final ValueNotifier<Order> _orderNotifier = ValueNotifier<Order>(
    Order(
      id: -1,
      customerId: '',
      orderDate: DateTime.now(),
      shippingAddress: '',
      billingAddress: '',
      totalAmount: 0,
      orderStatus: '',
    ),
  );

  List<String> orderStatuses = [
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  void onStatusChanged(String? newStatus) {
    if (newStatus != null) {
      _orderNotifier.value = _orderNotifier.value.copyWith(
        orderStatus: newStatus,
      );
    }
  }

  void updateOrderDetails(Order updatedOrder) {
    _orderNotifier.value = updatedOrder;
  }

  @override
  void initState() {
    super.initState();
    // Initialize the orderNotifier with the initial order
    _orderNotifier.value = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.black,
          middle: const Text(
            'Order Details',
            style: TextStyle(color: CupertinoColors.white),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),
        backgroundColor: CupertinoColors.black,
        child: SafeArea(
          child: CupertinoScrollbar(
            child: ValueListenableBuilder<Order>(
              valueListenable: _orderNotifier,
              builder: (context, order, child) {
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: [
                    Text(
                      'Order ID: ${order.id}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Customer: ${widget.customer.firstName} ${widget.customer.lastName}',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Total Amount: \$${order.totalAmount}',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Order Status: ${order.orderStatus}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 150,
                      child: CupertinoPicker(
                        itemExtent: 40,
                        onSelectedItemChanged: (int index) {
                          onStatusChanged(orderStatuses[index]);
                        },
                        children: orderStatuses.map<Text>((value) {
                          return Text(
                            value,
                            style: const TextStyle(fontSize: 18),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Ordered Items:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (OrderedItem orderedItem in widget.orderedItems)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Name: ${orderedItem.productName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CupertinoColors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Quantity: ${orderedItem.quantity}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CupertinoColors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Price: \$${orderedItem.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    CupertinoButton.filled(
                      child: const Text('Edit Order'),
                      onPressed: () async {
                        // Navigate to the EditOrderScreen
                        final updatedOrder = await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => EditOrderScreen(
                              order: order,
                              orderedItems: widget.orderedItems,
                              products: widget.products,
                              customer: widget.customer,
                            ),
                          ),
                        );

                        if (updatedOrder != null) {
                          updateOrderDetails(updatedOrder);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
