import 'dart:developer';

import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Orders/edit_order_screen.dart';
import 'package:flutter/cupertino.dart';

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
  void updateOrderDetails(Order updatedOrder) {
    // Update the order details and refresh the widget state.
    setState(() {
      widget.order.totalAmount = updatedOrder.totalAmount;
      widget.order.orderStatus = updatedOrder.orderStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Order Details'),
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
        child: SafeArea(
          child: CupertinoScrollbar(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Order ID: ${widget.order.id}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Customer: ${widget.customer.firstName} ${widget.customer.lastName}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total Amount: \$${widget.order.totalAmount}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Order Status: ${widget.order.orderStatus}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ordered Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.orderedItems.length,
                  itemBuilder: (context, index) {
                    OrderedItem orderedItem = widget.orderedItems[index];
                    log('OrderedItem ID: ${orderedItem.productId}');
                    Product product = widget.products.firstWhere(
                      (prod) {
                        log('Product ID: ${prod.id}');
                        return prod.id == orderedItem.productId;
                      },
                      orElse: () => Product(
                        id: 0,
                        name: 'Unknown Product',
                        retailPrice: 0,
                      ),
                    );

                    String productName = product.name;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Name: $productName',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Quantity: ${orderedItem.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Price: \$${orderedItem.price}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: const Text('Edit Order'),
                  onPressed: () async {
                    // Navigate to the EditOrderScreen
                    final updatedOrder = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EditOrderScreen(
                          order: widget.order,
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
            ),
          ),
        ),
      ),
    );
  }
}
