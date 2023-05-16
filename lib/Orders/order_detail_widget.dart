import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final People customer;
  final List<OrderedItem> orderedItems;

  OrderDetailScreen({
    required this.order,
    required this.customer,
    required this.orderedItems,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Order Details'),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildDetailRow('Order ID:', order.id.toString()),
            buildDetailRow('Customer ID:', order.customerId.toString()),
            buildDetailRow(
                'Customer Name:', '${customer.firstName} ${customer.lastName}'),
            buildDetailRow('Order Date:', order.orderDate.toString()),
            buildDetailRow('Shipping Address:', order.shippingAddress),
            buildDetailRow('Billing Address:', order.billingAddress),
            buildDetailRow('Total Amount:', '\$${order.totalAmount}'),
            buildDetailRow('Order Status:', order.orderStatus),
            SizedBox(height: 16),
            Text(
              'Ordered Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var item in orderedItems) buildOrderedItemRow(item),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildOrderedItemRow(OrderedItem item) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product ID: ${item.productId}',
                style: TextStyle(fontSize: 18),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Quantity: ${item.quantity}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Price: \$${item.price}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Discount: \$${item.discount}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Description: ${item.productDescription}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
