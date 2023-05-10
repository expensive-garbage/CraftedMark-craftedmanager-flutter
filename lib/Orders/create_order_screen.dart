import 'package:crafted_manager/models/order_model.dart';
import 'package:crafted_manager/models/ordered_item_model.dart';
import 'package:crafted_manager/models/people_model.dart';
import 'package:crafted_manager/models/product_model.dart';
import 'package:crafted_manager/orders/orders_db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateOrderScreen extends StatefulWidget {
  final People client;

  CreateOrderScreen({required this.client});

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<OrderedItem> orderedItems = [];
  double totalAmount = 0;

  void addOrderedItem(Product product, int quantity) {
    setState(() {
      OrderedItem newItem = OrderedItem(
        id: 0,
        orderId: 0,
        productId: product.id,
        quantity: quantity,
        price: product.retailPrice,
        discount: 0,
        description: product.description,
      );
      orderedItems.add(newItem);
      totalAmount += (newItem.price * newItem.quantity);
    });
  }

  void removeOrderedItem(int index) {
    setState(() {
      totalAmount -= (orderedItems[index].price * orderedItems[index].quantity);
      orderedItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
            'Create Order for ${widget.client.firstName} ${widget.client.lastName}'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text('Order Date'),
              trailing: Text(DateTime.now().toString().split(' ')[0]),
            ),
            ListTile(
              title: Text('Order Type'),
              trailing: Text('Retail'),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(orderedItems[index].description),
                  subtitle: Text('Qty: ${orderedItems[index].quantity}'),
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.minus_circle),
                    onPressed: () => removeOrderedItem(index),
                  ),
                );
              },
            ),
            CupertinoButton(
              child: Text('Add Item'),
              onPressed: () {
                // Navigate to product search screen and retrieve selected product and quantity
                // Example:
                // final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductSearchScreen()));
                // if (result != null) {
                //   addOrderedItem(result.product, result.quantity);
                // }
              },
            ),
            Divider(),
            ListTile(
              title: Text('Total Amount'),
              trailing: Text('\$${totalAmount.toStringAsFixed(2)}'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CupertinoButton.filled(
                child: Text('Create Order'),
                onPressed: () async {
                  final order = Order(
                    id: int.parse(Uuid().v1()),
                    customerId: widget.client.id,
                    orderDate: DateTime.now(),
                    shippingAddress: '',
                    billingAddress: '',
                    totalAmount: totalAmount,
                    orderStatus: 'Pending',
                  );

                  // Save the order to the database
                  await OrderPostgres.createOrder(order, orderedItems);

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
