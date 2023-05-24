import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late bool _backordered;
  late String _category;
  late double _costOfGood;
  late String _description;
  late String _flavor;
  final _formKey = GlobalKey<FormState>();
  late String _itemSource;
  late int _manufacturerId;
  late String _manufacturerName;
  late double _manufacturingPrice;
  late String _name;
  late int _quantityInStock;
  late int _quantitySold;
  late String _retailPrice;
  late int _stockQuantity;
  late String _subCategory;
  late String _subcat2;
  late String _supplier;
  late double _wholesalePrice;

  @override
  void initState() {
    super.initState();
    _name = widget.product.name;
    _category = widget.product.category;
    _subCategory = widget.product.subCategory;
    _subcat2 = widget.product.subcat2;
    _flavor = widget.product.flavor;
    _description = widget.product.description;
    _costOfGood = widget.product.costOfGood;
    _manufacturingPrice = widget.product.manufacturingPrice;
    _wholesalePrice = widget.product.wholesalePrice;
    _retailPrice = widget.product.retailPrice.toString();
    _stockQuantity = widget.product.stockQuantity;
    _backordered = widget.product.backordered;
    _supplier = widget.product.supplier;
    _manufacturerId = widget.product.manufacturerId.toString() as int;
    _manufacturerName = widget.product.manufacturerName;
    _itemSource = widget.product.itemSource;
    _quantitySold = widget.product.quantitySold;
    _quantityInStock = widget.product.quantityInStock;
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedProduct = Product(
        id: widget.product.id,
        name: _name,
        category: _category,
        subCategory: _subCategory,
        subcat2: _subcat2,
        flavor: _flavor,
        description: _description,
        costOfGood: _costOfGood,
        manufacturingPrice: _manufacturingPrice,
        wholesalePrice: _wholesalePrice,
        retailPrice: double.parse(_retailPrice),
        stockQuantity: _stockQuantity,
        backordered: _backordered,
        supplier: _supplier,
        manufacturerId: _manufacturerId,
        manufacturerName: _manufacturerName,
        itemSource: _itemSource,
        quantitySold: _quantitySold,
        quantityInStock: _quantityInStock,
      );

      try {
        await ProductPostgres.updateProduct(updatedProduct);
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Error'),
            content:
                const Text('An error occurred while updating the product.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
    }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Edit Product'),
        trailing: CupertinoButton(
          onPressed: _updateProduct,
          child: const Text('Save'),
        ),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _subCategory,
                decoration: const InputDecoration(labelText: 'Subcategory'),
                onSaved: (value) => _subCategory = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _subcat2,
                decoration: const InputDecoration(labelText: 'Subcategory 2'),
                onSaved: (value) => _subcat2 = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _flavor,
                decoration: const InputDecoration(labelText: 'Flavor'),
                onSaved: (value) => _flavor = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _costOfGood.toString(),
                decoration: const InputDecoration(labelText: 'Cost of Good'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _costOfGood = double.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _manufacturingPrice.toString(),
                decoration:
                const InputDecoration(labelText: 'Manufacturing Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _manufacturingPrice = double.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _wholesalePrice.toString(),
                decoration: const InputDecoration(labelText: 'Wholesale Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _wholesalePrice = double.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _retailPrice,
                decoration: const InputDecoration(labelText: 'Retail Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _retailPrice = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _stockQuantity.toString(),
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _stockQuantity = int.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _backordered.toString(),
                decoration: const InputDecoration(labelText: 'Backordered'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                _backordered = value == 'true' ? true : false,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _supplier,
                decoration: const InputDecoration(labelText: 'Supplier'),
                onSaved: (value) => _supplier =  value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a supplier';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _manufacturerId.toString(),
                decoration: const InputDecoration(labelText: 'Manufacturer ID'),
                onSaved: (value) => _manufacturerId = int.parse(value ?? "0"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a manufacturer ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _manufacturerName,
                decoration:
                const InputDecoration(labelText: 'Manufacturer Name'),
                onSaved: (value) => _manufacturerName = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a manufacturer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _itemSource,
                decoration: const InputDecoration(labelText: 'Item Source'),
                onSaved: (value) => _itemSource = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item source';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _quantitySold.toString(),
                decoration: const InputDecoration(labelText: 'Quantity Sold'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _quantitySold = int.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _quantityInStock.toString(),
                decoration:
                const InputDecoration(labelText: 'Quantity In Stock'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _quantityInStock = int.parse(value!),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );  }
}
