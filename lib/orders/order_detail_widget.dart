import 'package:flutter/cupertino.dart';

class OrderDetails extends StatelessWidget {
  final int orderId;

  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Order #$orderId'),
      ),
      child: SafeArea(
        child: Center(
          child: Text('Order Details for Order #$orderId'),
        ),
      ),
    );
  }
}
