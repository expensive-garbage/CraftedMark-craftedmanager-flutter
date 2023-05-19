import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Orders/orders_db_manager.dart';
import 'package:crafted_manager/Orders/product_search_screen.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateOrderScreen extends StatefulWidget {
  final People client;

  CreateOrderScreen({required this.client});

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<OrderedItem> orderedItems = [];
  double shippingCost = 10.0; // Default shipping cost

  void addOrderedItem(Product product, int quantity) {
    setState(() {
      orderedItems.add(OrderedItem(
        id: orderedItems.length + 1,
        orderId: 0,
        productName: product.name,
        // Fix the attribute name here
        productId: product.id,
        quantity: quantity,
        price: product.retailPrice,
        discount: 0,
        productDescription: product.description,
        productRetailPrice: product.retailPrice,
      ));
    });
  }

  Future<void> saveOrder() async {
    // Create a new Order instance with the necessary values from the People model
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch,
      customerId: widget.client.id.toString(),
      // Convert customerId to String
      // Add this line
      orderDate: DateTime.now(),
      shippingAddress:
          '${widget.client.address1}, ${widget.client.city}, ${widget.client.state}, ${widget.client.zip}',
      billingAddress:
          '${widget.client.address1}, ${widget.client.city}, ${widget.client.state}, ${widget.client.zip}',
      totalAmount: 0,
      orderStatus: 'Pending',
    );

    await OrderPostgres.createOrder(newOrder, orderedItems);
    print("Order saved");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double subTotal = orderedItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.productRetailPrice * element.quantity),
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Create Order'),
        trailing: GestureDetector(
          onTap: () async {
            await saveOrder();
            Navigator.pop(context);
          },
          child: Text(
            "Save Order",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: CupertinoButton.filled(
                child: Text('Add Item'),
                onPressed: () async {
                  List<Product> products =
                      await ProductPostgres.getAllProducts();

                  final result =
                      await showCupertinoModalPopup<Map<String, dynamic>>(
                    context: context,
                    builder: (BuildContext context) =>
                        ProductSearchScreen(products: products),
                  );

                  if (result != null) {
                    addOrderedItem(result['product'], result['quantity']);
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderedItems.length,
                itemBuilder: (context, index) {
                  return CupertinoListTile(
                    title: Text(orderedItems[index].productDescription),
                    trailing:
                        Text('\$${orderedItems[index].productRetailPrice}'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Qty: ${orderedItems[index].quantity}'),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            "Edit Qty",
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                int updatedQuantity =
                                    orderedItems[index].quantity;
                                return CupertinoAlertDialog(
                                  title: Text('Edit Quantity'),
                                  content: CupertinoPicker(
                                    itemExtent: 32,
                                    onSelectedItemChanged: (value) {
                                      updatedQuantity = value + 1;
                                    },
                                    children: List.generate(
                                      100,
                                      (index) => Text('${index + 1}'),
                                    ),
                                    scrollController:
                                        FixedExtentScrollController(
                                      initialItem:
                                          orderedItems[index].quantity - 1,
                                    ),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        setState(() {
                                          orderedItems[index].quantity =
                                              updatedQuantity;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("Update"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal:'),
                      Text('\$${subTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping:'),
                      Text('\$${shippingCost.toStringAsFixed(2)}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:'),
                      Text('\$${(subTotal + shippingCost).toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
