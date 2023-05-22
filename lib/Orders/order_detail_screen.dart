import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'orders_db_manager.dart';

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

  void onStatusChanged(String newStatus) {
    _orderNotifier.value = _orderNotifier.value.copyWith(
      orderStatus: newStatus,
    );
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
          trailing: GestureDetector(
            onTap: () {
              // Implement your edit order functionality here
            },
            child: const Icon(
              CupertinoIcons.pencil,
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
                    CupertinoButton(
                      child: const Text('Change Order Status'),
                      onPressed: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoActionSheet(
                              title: const Text('Select Order Status'),
                              actions: orderStatuses.map((status) {
                                return CupertinoActionSheetAction(
                                  child: Text(status),
                                  onPressed: () {
                                    onStatusChanged(status);
                                    Navigator.pop(context);
                                  },
                                );
                              }).toList(),
                              cancelButton: CupertinoActionSheetAction(
                                child: const Text('Cancel'),
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      },
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
                      child: const Text('Update Order Status'),
                      onPressed: () async {
                        final orderPostgres = OrderPostgres();
                        bool success = await orderPostgres
                            .updateOrderStatus(_orderNotifier.value);
                        if (success) {
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Success'),
                              content:
                                  const Text('Order status has been updated.'),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close Dialog
                                    Navigator.pop(context); // Close screen
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Error'),
                              content:
                                  const Text('Failed to update order status.'),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close Dialog
                                  },
                                ),
                              ],
                            ),
                          );
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
