import 'package:crafted_manager/Models/product_model.dart';
import 'package:crafted_manager/Products/product_db_manager.dart';
import 'package:crafted_manager/Products/product_detail.dart';
import 'package:flutter/cupertino.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = Future.value([]);
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    _products = ProductPostgres.getAllProducts();
    setState(() {});
    _products.then((value) => print('Fetched products: $value'));
  }

  void createNewProduct() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ProductDetailPage(
          product: Product(id: 0, name: 'Unknown Product', retailPrice: 0),
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Products List'),
        trailing: GestureDetector(
          onTap: createNewProduct,
          child: Icon(CupertinoIcons.add),
        ),
      ),
      child: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                print('Product at index $index: $product');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
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
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Retail Price: \$${product.retailPrice}'),
                        Text('Wholesale Price: \$${product.wholesalePrice}'),
                        Text('Supplier: ${product.manufacturerName}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
