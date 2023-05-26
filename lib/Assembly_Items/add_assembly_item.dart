import 'package:crafted_manager/Assembly_Items/assembly_items_db_manager.dart';
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
  List<Map<String, dynamic>> _ingredients = [];
  double _price = 0.0;

  List<Product> products = [];
  TextEditingController _productSearchController = TextEditingController();
  List<Product> _filteredProducts = [];

  int? _selectedProductId;

  get imgurl => null;

  @override
  void initState() {
    super.initState();
    getProductList();
    _filteredProducts = products;
    _productSearchController.addListener(() {
      _filterProducts(_productSearchController.text);
    });
  }

  Future<void> getProductList() async {
    // Fetch your product list here and set it to 'products' variable.
    products = [
      Product(id: 1, name: 'Product 1', retailPrice: 9.99, assemblyItems: []),
      Product(id: 2, name: 'Product 2', retailPrice: 10.99, assemblyItems: []),
      Product(id: 3, name: 'Product 3', retailPrice: 11.99, assemblyItems: []),
    ];
    setState(() {
      _filteredProducts = products;
    });
  }

  @override
  void dispose() {
    _productSearchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  void _addNewIngredient() {
    setState(() {
      _ingredients.add({
        'ingredient': null,
        'quantity': null,
        'unit': null,
      });
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    AssemblyItemsPostgres dbManager = AssemblyItemsPostgres();
    AssemblyItem newAssemblyItem = AssemblyItem(
      id: -1,
      productId: _selectedProductId ?? -1,
      ingredientId: -1,
      quantity: 0.0,
      unit: '',
    );

    Product assemblyProduct = Product(
      id: null,
      name: "Assembled Product",
      description: "",
      retailPrice: _price,
      assemblyItems: [],
      imageUrl: "",
    );

    try {
      await dbManager.addAssemblyItem(
          newAssemblyItem, _ingredients, assemblyProduct);
      print("Assembly item added successfully");
    } catch (e) {
      print("Error adding assembly item: $e");
    }
  }

  Widget _buildProductSearchBox() {
    return CupertinoFormSection(
      header:
          const Text('Product', style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoSearchTextField(
            controller: _productSearchController,
            placeholder: 'Search for a product',
            onChanged: (value) {
              _filterProducts(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductDropdown() {
    return CupertinoFormSection(
      header: const Text('Select Product',
          style: TextStyle(color: CupertinoColors.white)),
      children: [
        CupertinoFormRow(
          child: CupertinoPicker(
            backgroundColor: CupertinoColors.black,
            itemExtent: 32.0,
            onSelectedItemChanged: (int value) {
              setState(() {
                _selectedProductId = _filteredProducts[value].id;
              });
            },
            children: _filteredProducts.map((product) {
              return Text(product.name,
                  style: const TextStyle(color: CupertinoColors.white));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientDropdown(int index) {
    return CupertinoFormSection(
      header: Text(
        'Select Ingredient ${index + 1}',
        style: TextStyle(color: CupertinoColors.white),
      ),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            placeholder: 'Ingredient name',
            onChanged: (value) {
              setState(() {
                _ingredients[index]['ingredient'] = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityInput(int index) {
    return CupertinoFormSection(
      header: Text(
        'Enter Quantity ${index + 1}',
        style: TextStyle(color: CupertinoColors.white),
      ),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            keyboardType: TextInputType.number,
            placeholder: 'Quantity',
            onChanged: (value) {
              setState(() {
                _ingredients[index]['quantity'] = double.tryParse(value);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUnitInput(int index) {
    return CupertinoFormSection(
      header: Text(
        'Enter Unit ${index + 1}',
        style: TextStyle(color: CupertinoColors.white),
      ),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            placeholder: 'Unit',
            onChanged: (value) {
              setState(() {
                _ingredients[index]['unit'] = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInput() {
    return CupertinoFormSection(
      header: Text(
        'Enter Price',
        style: TextStyle(color: CupertinoColors.white),
      ),
      children: [
        CupertinoFormRow(
          child: CupertinoTextField(
            keyboardType: TextInputType.number,
            placeholder: 'Price',
            onChanged: (value) {
              setState(() {
                _price = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: Container(
        color: CupertinoColors.darkBackgroundGray,
        padding: const EdgeInsets.all(16),
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
                _buildProductSearchBox(),
                _buildProductDropdown(),
                const SizedBox(height: 16),
                for (int i = 0; i < _ingredients.length; i++)
                  Column(
                    children: [
                      _buildIngredientDropdown(i),
                      const SizedBox(height: 16),
                      _buildQuantityInput(i),
                      const SizedBox(height: 16),
                      _buildUnitInput(i),
                      const SizedBox(height: 16),
                    ],
                  ),
                _buildPriceInput(),
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
    );
  }
}
