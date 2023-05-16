import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _retailPriceController = TextEditingController();

  void _saveProduct() async {
    if (_descriptionController.text.isNotEmpty &&
        _retailPriceController.text.isNotEmpty) {
      Product newProduct = Product(
        id: 0,
        description: _descriptionController.text,
        retailPrice: double.parse(_retailPriceController.text),
      );
      await ProductPostgres.saveProduct(newProduct);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add Product'),
        trailing: GestureDetector(
          onTap: _saveProduct,
          child: Text(
            "Save",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CupertinoTextField(
            controller: _descriptionController,
            placeholder: 'Description',
          ),
          SizedBox(height: 16),
          CupertinoTextField(
            controller: _retailPriceController,
            placeholder: 'Retail Price',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
