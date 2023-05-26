import 'package:crafted_manager/Models/assembly_item_model.dart';
import 'package:crafted_manager/Models/product_model.dart';
import 'package:flutter/cupertino.dart';

class AddAssemblyItem extends StatefulWidget {
  @override
  _AddAssemblyItemState createState() => _AddAssemblyItemState();
}

class _AddAssemblyItemState extends State<AddAssemblyItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AssemblyItem _assemblyItem;

  // Example products list
  List<Product> products = [];

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Add your assembly item to the database here.
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add Assembly Item'),
      ),
      child: Container(
        color: CupertinoColors.darkBackgroundGray,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Add Assembly Item',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                _buildProductDropdown(),
                SizedBox(height: 16),
                _buildIngredientDropdown(),
                SizedBox(height: 16),
                _buildQuantityInput(),
                SizedBox(height: 16),
                _buildUnitInput(),
                SizedBox(height: 32),
                CupertinoButton.filled(
                  child: Text('Create Assembly Item'),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDropdown() {
    return CupertinoFormSection(
      header: Text('Product', style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoPicker(
            backgroundColor: CupertinoColors.black,
            itemExtent: 32.0,
            onSelectedItemChanged: (int value) {
              // Handle selected product ID here
            },
            children: products.map((product) {
              return Text(product.name,
                  style: TextStyle(color: CupertinoColors.white));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientDropdown() {
    return CupertinoFormSection(
      header:
          Text('Ingredient', style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoPicker(
            backgroundColor: CupertinoColors.black,
            itemExtent: 32.0,
            onSelectedItemChanged: (int value) {
              // Handle selected ingredient ID here
            },
            children: products.map((product) {
              return Text(product.name,
                  style: TextStyle(color: CupertinoColors.white));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityInput() {
    return CupertinoFormSection(
      header: Text('Quantity', style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            placeholder: 'Enter quantity',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (String? value) {
              // Handle quantity input here
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUnitInput() {
    return CupertinoFormSection(
      header: Text('Unit', style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            placeholder: 'Enter unit',
            onSubmitted: (String? value) {
              // Handle unit input here
            },
          ),
        ),
      ],
    );
  }
}
