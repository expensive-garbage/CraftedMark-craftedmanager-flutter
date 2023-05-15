import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final bool isNewProduct;
  final Function onProductSaved;

  ProductDetailPage(
      {required this.product,
      this.isNewProduct = false,
      required this.onProductSaved});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subCategoryController = TextEditingController();
  final _subcat2Controller = TextEditingController();
  final _flavorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costOfGoodController = TextEditingController();
  final _manufacturingPriceController = TextEditingController();
  final _wholesalePriceController = TextEditingController();
  final _retailPriceController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  final _itemSourceController = TextEditingController();
  final _manufacturerNameController = TextEditingController();
  final _supplierController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _categoryController.text = widget.product.category;
    _subCategoryController.text = widget.product.subCategory;
    _subcat2Controller.text = widget.product.subcat2;
    _flavorController.text = widget.product.flavor;
    _descriptionController.text = widget.product.description;
    _costOfGoodController.text = widget.product.costOfGood.toString();
    _manufacturingPriceController.text =
        widget.product.manufacturingPrice.toString();
    _wholesalePriceController.text = widget.product.wholesalePrice.toString();
    _retailPriceController.text = widget.product.retailPrice.toString();
    _stockQuantityController.text = widget.product.stockQuantity.toString();
    _itemSourceController.text = widget.product.itemSource;
    _manufacturerNameController.text = widget.product.manufacturerName;
    _supplierController.text = widget.product
        .supplier; // Assuming you have a supplier field in your Product model
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.isNewProduct ? 'New Product' : 'Edit Product'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CupertinoTextFormFieldRow(
                    controller: _nameController,
                    prefix: Text('Name: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _categoryController,
                    prefix: Text('Category: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _subCategoryController,
                    prefix: Text('Subcategory: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _subcat2Controller,
                    prefix: Text('Subcategory 2: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _flavorController,
                    prefix: Text('Flavor: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _descriptionController,
                    prefix: Text('Description: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _costOfGoodController,
                    keyboardType: TextInputType.number,
                    prefix: Text('Cost of Good: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _manufacturingPriceController,
                    keyboardType: TextInputType.number,
                    prefix: Text('Manufacturing Price: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _wholesalePriceController,
                    keyboardType: TextInputType.number,
                    prefix: Text('Wholesale Price: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _retailPriceController,
                    keyboardType: TextInputType.number,
                    prefix: Text('Retail Price: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _stockQuantityController,
                    keyboardType: TextInputType.number,
                    prefix: Text('Stock Quantity: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _itemSourceController,
                    prefix: Text('Item Source: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _manufacturerNameController,
                    prefix: Text('Manufacturer Name: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _supplierController,
                    prefix: Text('Supplier: '),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoButton.filled(
                    child: Text('Save'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await saveProduct();
                          widget.onProductSaved();
                          Navigator.pop(context);
                        } catch (e) {
                          print('Error: $e');
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text('Error'),
                                content: Text(
                                    'An error occurred while saving the product.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveProduct() async {
    Product updatedProduct = Product(
      id: widget.product.id,
      name: _nameController.text,
      category: _categoryController.text,
      subCategory: _subCategoryController.text,
      subcat2: _subcat2Controller.text,
      flavor: _flavorController.text,
      description: _descriptionController.text,
      costOfGood: double.parse(_costOfGoodController.text),
      manufacturingPrice: double.parse(_manufacturingPriceController.text),
      wholesalePrice: double.parse(_wholesalePriceController.text),
      retailPrice: double.parse(_retailPriceController.text),
      stockQuantity: int.parse(_stockQuantityController.text),
      backordered: false,
      supplier: _supplierController.text,
      manufacturerId: widget.product.manufacturerId,
      manufacturerName: _manufacturerNameController.text,
      itemSource: _itemSourceController.text,
      quantitySold: widget.product.quantitySold,
      quantityInStock: widget.product.quantityInStock,
    );

    if (widget.isNewProduct) {
      await ProductPostgres.addProduct(updatedProduct);
    } else {
      await ProductPostgres.updateProduct(updatedProduct);
    }
  }
}
