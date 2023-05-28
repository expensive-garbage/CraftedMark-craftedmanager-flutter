import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:crafted_manager/Products/product_detail.dart';
import 'package:flutter/material.dart';

// Add this function right below import statements
String indexToType(int index) {
  switch (index) {
    case 0:
      return 'Product';
    case 1:
      return 'Service';
    case 2:
      return 'Ingredient';
    case 3:
      return 'Assembly';
    default:
      return 'Unknown';
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _products;
  int _currentSegmentIndex = 0;

  @override
  void initState() {
    super.initState();
    _products = Future.value([]);
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    print('Fetching products for type: ${indexToType(_currentSegmentIndex)}');
    _products =
        ProductPostgres.getAllProducts(indexToType(_currentSegmentIndex));
    _products.then((value) {
      print('Fetched products: $value');
      setState(() {
        _products = Future.value(value); // Update the products list.
      });
    });
  }

  void createNewProduct() {
    // Configure the new product based on the current segment index.
    Product newProduct = Product(
        id: 0,
        name: 'Unknown Product',
        retailPrice: 0,
        type: indexToType(_currentSegmentIndex),
        assemblyItems: []);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          product: newProduct,
          isNewProduct: true,
          onProductSaved: () {
            // Refresh product list after adding a new product
            _fetchProducts();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Products List'),
        actions: [
          IconButton(
            onPressed: createNewProduct,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: DropdownButton<int>(
                    value: _currentSegmentIndex,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(
                          () {
                            _currentSegmentIndex = newValue;
                            _fetchProducts();
                          },
                        );
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: const Text('Products'),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('Services'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: const Text('Ingredients'),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: const Text('Assembly Items'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        print('Product at index $index: $product');
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  product: product,
                                  onProductSaved: () {
                                    // Refresh product list after updating a product
                                    _fetchProducts();
                                  },
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Text(
                                  'Retail Price: \$${product.retailPrice}'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                      product: product,
                                      onProductSaved: () {
                                        // Refresh product list after updating a product
                                        _fetchProducts();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
