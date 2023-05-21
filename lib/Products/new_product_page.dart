import 'package:flutter/cupertino.dart';

class NewProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('New Product'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('New product form goes here.'),
        ),
      ),
    );
  }
}
