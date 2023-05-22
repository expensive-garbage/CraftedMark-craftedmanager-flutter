import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../../Orders/orders_db_manager.dart';
import 'product_search_screen.dart';

class EditOrderScreen extends StatefulWidget {
  final Order order;
  final List<OrderedItem> orderedItems;
  final People customer;
  final List<Product> products;

  EditOrderScreen({
    required this.order,
    required this.orderedItems,
    required this.customer,
    required this.products,
  });

  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  late List<OrderedItem> _orderedItems;
  double _subTotal = 0.0;
  String _status = '';

  @override
  void initState() {
    super.initState();
    _orderedItems = List.from(widget.orderedItems);
    _subTotal = calculateSubtotal();
    _status = widget.order.orderStatus;
  }

  double calculateSubtotal() {
    return _orderedItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );
  }

  void editOrderedItem(int index) {
    if (_orderedItems[index].quantity > 1) {
      setState(() {
        _orderedItems[index] = _orderedItems[index].copyWith(
          quantity: _orderedItems[index].quantity - 1,
        );
        _subTotal = calculateSubtotal();
      });
    } else {
      setState(() {
        _orderedItems.removeAt(index);
        _subTotal = calculateSubtotal();
      });
    }
  }

  void addOrderedItem(Product product, int quantity) {
    int existingIndex = _orderedItems
        .indexWhere((orderedItem) => orderedItem.productId == product.id);

    if (existingIndex != -1) {
      setState(() {
        _orderedItems[existingIndex] = _orderedItems[existingIndex].copyWith(
          quantity: _orderedItems[existingIndex].quantity + quantity,
        );
        _subTotal = calculateSubtotal();
      });
    } else {
      setState(() {
        _orderedItems.add(OrderedItem(
          id: _orderedItems.length + 1,
          orderId: widget.order.id,
          productName: product.name,
          productId: product.id!,
          name: product.name,
          quantity: quantity,
          price: product.retailPrice,
          discount: 0,
          productDescription: product.description,
          productRetailPrice: product.retailPrice,
        ));
        _subTotal = calculateSubtotal();
      });
    }
  }

  Future<Order?> updateOrder() async {
    Order updatedOrder = widget.order.copyWith(
      totalAmount: _subTotal,
      orderStatus: _status,
    );

    final result = await OrderPostgres.updateOrder(updatedOrder, _orderedItems);

    if (result) {
      return updatedOrder;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.dark),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Edit Order'),
          trailing: GestureDetector(
            onTap: () async {
              final updatedOrder = await updateOrder();
              if (updatedOrder != null) {
                Navigator.pop(context, updatedOrder);
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: const Text("Error"),
                    content: const Text("Failed to update order."),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CupertinoFormSection.insetGrouped(
                  header: const Text('Order information'),
                  children: [
                    CupertinoTextFormFieldRow(
                      prefix: const Text('Customer:'),
                      enabled: false,
                      initialValue: widget.customer.firstName +
                          ' ' +
                          widget.customer.lastName,
                    ),
                    CupertinoFormRow(
                      prefix: const Text('Status:'),
                      child: CupertinoSlidingSegmentedControl<String>(
                        thumbColor: CupertinoColors.activeBlue,
                        children: const <String, Widget>{
                          'Pending': Text('Pending'),
                          'In-Progress': Text('In-Progress'),
                          'Completed': Text('Completed'),
                        },
                        groupValue: _status,
                        onValueChanged: (String? value) {
                          setState(() {
                            _status = value ?? '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CupertinoButton.filled(
                  child: const Text('Add Item'),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _orderedItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_orderedItems[index].id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        _orderedItems.removeAt(index);
                        _subTotal = calculateSubtotal();
                      });
                    },
                    background:
                        Container(color: CupertinoColors.destructiveRed),
                    child: Container(
                      color: CupertinoColors.black,
                      child: CupertinoFormRow(
                        prefix: Row(
                          children: [
                            Text(_orderedItems[index].productName),
                            const SizedBox(width: 8),
                            Text('Qty: ${_orderedItems[index].quantity}'),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            editOrderedItem(index);
                          },
                          child: const Icon(CupertinoIcons.minus_circled,
                              color: CupertinoColors.destructiveRed),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text('\$${_subTotal.toStringAsFixed(2)}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
