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
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Add Assembly Item'),
        ),
        child: Container(
          color: CupertinoColors.darkBackgroundGray,
          padding: const EdgeInsets.only(top:45 , left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Add Assembly Item',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProductDropdown(),
                  const SizedBox(height: 16),
                  _buildIngredientDropdown(),
                  const SizedBox(height: 16),
                  _buildQuantityInput(),
                  const SizedBox(height: 16),
                  _buildUnitInput(),
                  const SizedBox(height: 32),
                  CupertinoButton.filled(
                    child: const Text('Create Assembly Item'),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDropdown() {
    return CupertinoFormSection(
      header:
          const Text('Product', style: TextStyle(color: CupertinoColors.white)),
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
                  style: const TextStyle(color: CupertinoColors.white));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientDropdown() {
    return CupertinoFormSection(
      header: const Text('Ingredient',
          style: TextStyle(color: CupertinoColors.white)),
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
                  style: const TextStyle(color: CupertinoColors.white));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityInput() {
    return CupertinoFormSection(
      header: const Text('Quantity',
          style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            placeholder: 'Enter quantity',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
      header:
          const Text('Unit', style: TextStyle(color: CupertinoColors.white)),
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
