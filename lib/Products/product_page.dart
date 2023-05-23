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
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Products List'),
        trailing: GestureDetector(
          onTap: createNewProduct,
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    child: CupertinoContextMenu(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              CupertinoColors.darkBackgroundGray,
                              CupertinoColors.black
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: CupertinoColors.systemGrey6),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.tag_fill,
                                        size: 20,
                                        color: CupertinoColors.systemGrey3),
                                    const SizedBox(width: 4),
                                    Text(
                                        'Retail Price: \$${product.retailPrice}',
                                        style: const TextStyle(
                                            color:
                                                CupertinoColors.systemGrey3)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.tag,
                                        size: 20,
                                        color: CupertinoColors.systemGrey3),
                                    const SizedBox(width: 4),
                                    Text(
                                        'Wholesale Price: \$${product.wholesalePrice}',
                                        style: const TextStyle(
                                            color:
                                                CupertinoColors.systemGrey3)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.person_2_fill,
                                        size: 20,
                                        color: CupertinoColors.systemGrey3),
                                    const SizedBox(width: 4),
                                    Text(
                                        'Supplier: ${product.manufacturerName}',
                                        style: const TextStyle(
                                            color:
                                                CupertinoColors.systemGrey3)),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(CupertinoIcons.chevron_right,
                                color: CupertinoColors.systemGrey2),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        CupertinoContextMenuAction(
                          child: const Text('Edit'),
                          onPressed: () {
                            Navigator.pop(context);
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
                        ),
                        CupertinoContextMenuAction(
                          isDestructiveAction: true,
                          child: const Text('Delete'),
                          onPressed: () {
                            // Implement the delete function
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: CupertinoColors.systemGrey3)),
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
