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
  void editOrder() {
    // Implement your logic for editing the order here.
    print('Edit order button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Order Details'),
        ),
        child: SafeArea(
          child: CupertinoScrollbar(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  'Order ID: ${widget.order.id}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // ...
                SizedBox(height: 16),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text('Edit Order'),
                  onPressed: () {
                    editOrder();
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Ordered Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Amount: \$${widget.order.totalAmount}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Order Status: ${widget.order.orderStatus}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Ordered Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.orderedItems.length,
                  itemBuilder: (context, index) {
                    OrderedItem orderedItem = widget.orderedItems[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Name: ${orderedItem.productName}',
                          // Display product name here
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Quantity: ${orderedItem.quantity}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Price: \$${orderedItem.price}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
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
