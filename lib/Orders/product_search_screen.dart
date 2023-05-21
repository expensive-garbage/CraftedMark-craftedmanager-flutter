import 'package:crafted_manager/Models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSearchScreen extends StatefulWidget {
  final List<Product> products;

  ProductSearchScreen({required this.products});

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  late List<Product> filteredProducts;
  int selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = widget.products
          .where((product) => product.description
              .toLowerCase()
              .contains(query.trim().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Search Product'),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CupertinoTextField(
                  controller: _searchController,
                  onChanged: _filterProducts,
                  placeholder: 'Search product',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: Colors.transparent,
                      child: CupertinoListTile(
                        title: Text(filteredProducts[index].name),
                        subtitle: Text(filteredProducts[index].description),
                        trailing:
                            Text('\$${filteredProducts[index].retailPrice}'),
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Add to Order'),
                                content: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(filteredProducts[index]
                                        .name), // Changed this line
                                    const SizedBox(height: 8),
                                    CupertinoPicker(
                                      itemExtent: 32,
                                      onSelectedItemChanged: (value) {
                                        selectedQuantity = value + 1;
                                      },
                                      children: List.generate(
                                        100,
                                        (index) => Text('${index + 1}'),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(
                                        context,
                                        {
                                          'product': filteredProducts[index],
                                          'quantity': selectedQuantity,
                                        },
                                      );
                                    },
                                    child: const Text("Add to Order"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
