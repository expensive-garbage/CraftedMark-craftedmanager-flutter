import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/postgres.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/products.dart';


class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _supplierController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _supplierController = TextEditingController(text: widget.product.supplier.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
        middle: Text('Edit Product'),
    ),
    child: ListView(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    children: [
    CupertinoTextField(
    controller: _nameController,
    placeholder: 'Product Name',
    ),
    SizedBox(height: 8.0),
    CupertinoTextField(
    controller: _priceController,
    placeholder: 'Price',
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    ),
    SizedBox(height: 8.0),
    CupertinoTextField(
    controller: _supplierController,
    placeholder: 'Supplier',
    ),
      SizedBox(height: 16.0),
      CupertinoButton(
        color: CupertinoColors.activeBlue,
        onPressed: () async {
          int? productId = int.tryParse(widget.product.id);
          if (productId != null) {
            await updateData(
              'products',
              productId,
              {
                'name': _nameController.text,
                'price': _priceController.text,
                'supplier': _supplierController.text,
              },
            );
            Navigator.pop(context);
          } else {
            // Handle the case where the product ID is not a valid integer
          }
        },
        child: Text('Update Product'),
      )
    ],
    ),
    );
  }
}
