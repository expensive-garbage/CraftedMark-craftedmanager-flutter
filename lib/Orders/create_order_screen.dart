import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Orders/product_search_screen.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Orders/orders_db_manager.dart';

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
        productId: product.id!,
        name: product.name,
        quantity: quantity,
        price: product.retailPrice,
        discount: 0,
        productDescription: product.description,
        productRetailPrice: product.retailPrice,
      ));
    });
  }

  Future<void> saveOrder() async {
    double subTotal = orderedItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );
    double totalAmount = subTotal + shippingCost;

    // Create a new Order instance with the necessary values from the People model
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch,
      customerId: widget.client.id.toString(),
      // Convert customerId to String
      orderDate: DateTime.now(),
      shippingAddress:
          '${widget.client.address1}, ${widget.client.city},${widget.client.state},${widget.client.zip}',
      billingAddress:
          '${widget.client.address1},${widget.client.city},${widget.client.state},${widget.client.zip}',
      productName: orderedItems.map((e) => e.productName).toList().join(','),
      // Convert the list of product names to a comma-separated string
      totalAmount: totalAmount,
      orderStatus: 'Pending',
    );

    Future<void> createOrder(
        Order order, List<OrderedItem> orderedItems) async {
      print("Creating new order...");
      print("Order data: ${newOrder.toMap()}");
      print(
          "Ordered items data: ${orderedItems.map((e) => e.toMap()).toList()}");

      await OrderPostgres().createOrder(newOrder, orderedItems);
    }

    await createOrder(
        newOrder, orderedItems); // Call the 'createOrder' method here
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
        middle: const Text('Create Order'),
        trailing: GestureDetector(
          onTap: () async {
            await saveOrder();
            Navigator.pop(context);
          },
          child: const Text(
            "Save Order",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CupertinoButton.filled(
                child: const Text('Add Item'),
                onPressed: () async {
                  List<Product> products =
                      await ProductPostgres.getAllProductsExceptIngredients();

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
                    title: Text(orderedItems[index].productName),
                    trailing:
                        Text('\$${orderedItems[index].productRetailPrice}'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Qty: ${orderedItems[index].quantity}'),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text(
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
                                  title: const Text('Edit Quantity'),
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
                                      child: const Text("Cancel"),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        setState(() {
                                          orderedItems[index].quantity =
                                              updatedQuantity;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Update"),
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
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal:'),
                      Text('\$${subTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Shipping:'),
                      Text('\$${shippingCost.toStringAsFixed(2)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:'),
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
