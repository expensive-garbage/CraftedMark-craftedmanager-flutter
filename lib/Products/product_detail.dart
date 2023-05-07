import 'package:flutter/cupertino.dart';
import 'package:crafted_manager/models/product_model.dart';
import 'package:crafted_manager/models/people_model.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail({required this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _category;
  late String _subCategory;
  late String _subcat2;
  late String _flavor;
  late String _description;
  late double _costOfGood;
  late double _manufacturingPrice;
  late double _wholesalePrice;
  late double _retailPrice;
  late int _stockQuantity;
  late bool _backordered;
  late People _supplier;
  late int _manufacturerId;
  late String _manufacturerName;
  late String _itemSource;
  late int _quantitySold;
  late int _quantityInStock;

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
    _retailPrice = widget.product.retailPrice;
    _stockQuantity = widget.product.stockQuantity;
    _backordered = widget.product.backordered;
    _supplier = widget.product.supplier;
    _manufacturerId = widget.product.manufacturerId;
    _manufacturerName = widget.product.manufacturerName;
    _itemSource = widget.product.itemSource;
    _quantitySold = widget.product.quantitySold;
    _quantityInStock = widget.product.quantityInStock;

    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
        middle: const Text('Product Detail'),
    trailing: CupertinoButton(
    child: const Icon(CupertinoIcons.trash),
    onPressed: () {
    // Implement delete product functionality
    print('Delete product');
    },
    ),
    ),
    child: SafeArea(
    child: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    // Name TextFormField
    CupertinoFormRow(
    child: CupertinoTextFormFieldRow(
    initialValue: _name,
    placeholder: 'Enter name',
    onChanged: (value) {
    _name = value;
    print('Name: $_name');
    },
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a name';
    }
    return null;
    },
    ),
    prefix: const Text('Name'),
    ),
    const SizedBox(height: 8.0),
    // Category TextFormField
    // ...
    // Retail Price TextFormField
    // ...
    // Supplier ID TextFormField
    CupertinoFormRow(
    child: CupertinoTextFormFieldRow(
    initialValue: _supplier.id.toString(),
    placeholder: 'Enter supplier id',
    onChanged: (value) {
    if (value.isNotEmpty) {
    _supplier = _supplier.copyWith(id: int.parse(value));
    print('Supplier ID: ${_supplier.id}');
    }
    },
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a supplier ID';
    }
    return null;
    },
    ),
    prefix: const Text('Supplier ID'),
    ),
    const SizedBox(height: 8.0),
    // Manufacturer ID TextFormField
    CupertinoFormRow(
    child: CupertinoTextFormFieldRow(
    initialValue: _manufacturerId.toString(),
    placeholder: 'Enter manufacturer id',
    onChanged: (value) {
    _manufacturerId = int.parse(value);
    print('Manufacturer ID: $_manufacturerId');
    },
    ),
    prefix: const Text('Manufacturer ID'),
    ),
    const SizedBox(height: 8.0),
    // Manufacturer Name TextFormField
      CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
          initialValue: _supplier.id.toString(),
          placeholder: 'Enter supplier id',
          onChanged: (value) {
            if (value.isNotEmpty) {
              _supplier = _supplier.copyWith(id: int.parse(value));
              print('Supplier ID: ${_supplier.id}');
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a supplier ID';
            }
            return null;
          },
        ),
        prefix: const Text('Supplier ID'),
      ),
      const SizedBox(height: 8.0),
      // Manufacturer ID TextFormField
      CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
          initialValue: _manufacturerId.toString(),
          placeholder: 'Enter manufacturer id',
          onChanged: (value) {
            _manufacturerId = int.parse(value);
            print('Manufacturer ID: $_manufacturerId');
          },
        ),
        prefix: const Text('Manufacturer ID'),
      ),
      const SizedBox(height: 8.0),
      // Manufacturer Name TextFormField
      CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
          initialValue: _manufacturerName,
          placeholder: 'Enter manufacturer name',
          onChanged: (value) {
            _manufacturerName = value;
            print('Manufacturer Name: $_manufacturerName');
          },
        ),
        prefix: const Text('Manufacturer Name'),
      ),
      const SizedBox(height: 8.0),
      // Item Source TextFormField
      CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
          initialValue: _itemSource,
          placeholder: 'Enter item source',
          onChanged: (value) {
            _itemSource = value;
            print('Item Source: $_itemSource');
          },
        ),
        prefix: const Text('Item Source'),
      ),
      const SizedBox(height: 8.0),
      // Save button
      CupertinoButton.filled(
        child: const Text('Save'),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final newProduct = Product(
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
              retailPrice: _retailPrice,
              stockQuantity: _stockQuantity,
              backordered: _backordered,
              supplier: _supplier,
              manufacturerId: _manufacturerId,
              manufacturerName: _manufacturerName,
              itemSource: _itemSource,
              quantitySold: _quantitySold,
              quantityInStock: _quantityInStock,
            );
            // Update the product
            // widget.updateProduct(newProduct);
            print('Product saved');
            Navigator.of(context).pop();
          }
        },
      ),
    ],
    ),
    ),
    ),
    ),
    );
  }
}
