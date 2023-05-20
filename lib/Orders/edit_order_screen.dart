import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Orders/orders_db_manager.dart';
import 'package:crafted_manager/Orders/product_search_screen.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';

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

  @override
  void initState() {
    super.initState();
    _orderedItems = List.from(widget.orderedItems);
  }

  void addOrderedItem(Product product, int quantity) {
    setState(() {
      _orderedItems.add(OrderedItem(
        id: _orderedItems.length + 1,
        orderId: widget.order.id,
        productName: product.name,
        productId: product.id,
        name: product.name,
        quantity: quantity,
        price: product.retailPrice,
        discount: 0,
        productDescription: product.description,
        productRetailPrice: product.retailPrice,
      ));
    });
  }

  Future<void> updateOrder() async {
    Order updatedOrder = Order(
      id: widget.order.id,
      customerId: widget.customer.id.toString(),
      orderDate: widget.order.orderDate,
      shippingAddress: widget.order.shippingAddress,
      billingAddress: widget.order.billingAddress,
      totalAmount: _orderedItems.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity),
      ),
      orderStatus: widget.order.orderStatus,
    );

    await OrderPostgres.updateOrder(updatedOrder, _orderedItems);
    Navigator.pop(context, updatedOrder);
  }

  @override
  Widget build(BuildContext context) {
    double subTotal = _orderedItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.productRetailPrice * element.quantity),
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Edit Order'),
        trailing: GestureDetector(
          onTap: () async {
            await updateOrder();
          },
          child: Text(
            "Save",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _orderedItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_orderedItems[index].id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      _orderedItems.removeAt(index);
                    });
                  },
                  background: Container(color: CupertinoColors.destructiveRed),
                  child: CupertinoListTile(
                    title: Text(_orderedItems[index].productName),
                    subtitle: Text('Qty: ${_orderedItems[index].quantity}'),
                  ),
                );
              },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
