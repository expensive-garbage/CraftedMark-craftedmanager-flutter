import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:flutter/cupertino.dart';


class ProductDetailPage extends StatefulWidget {
  final Product product;
  final bool isNewProduct;

  ProductDetailPage({required this.product, this.isNewProduct = false});

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
                    placeholder: 'Name',
                    keyboardType: TextInputType.text,
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _categoryController,
                    placeholder: 'Category',
                    keyboardType: TextInputType.text,
                  ),
                  // ...
                  // Add other CupertinoTextFormFieldRows for each field
                  // ...
                  CupertinoButton.filled(
                    child: Text('Save'),
                    onPressed: () async {
                      await saveProduct();
                      Navigator.pop(context);
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
      //id: widget.isNewProduct ? Uuid().v4() : widget.product.id,
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
      stockQuantity: double.parse(_stockQuantityController.text),
      backordered: false,
      manufacturerName: widget.product.manufacturerName,
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
