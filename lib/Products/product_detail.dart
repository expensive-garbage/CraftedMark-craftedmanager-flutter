import 'package:crafted_manager/Models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Product Details'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${product.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Category: ${product.category}'),
              SizedBox(height: 8),
              Text('Sub-Category: ${product.subCategory}'),
              SizedBox(height: 8),
              Text('Subcat2: ${product.subcat2}'),
              SizedBox(height: 8),
              Text('Flavor: ${product.flavor}'),
              SizedBox(height: 8),
              Text('Description: ${product.description}'),
              SizedBox(height: 8),
              Text('Cost of Good: ${product.costOfGood}'),
              SizedBox(height: 8),
              Text('Manufacturing Price: ${product.manufacturingPrice}'),
              SizedBox(height: 8),
              Text('Wholesale Price: ${product.wholesalePrice}'),
              SizedBox(height: 8),
              Text('Retail Price: ${product.retailPrice}'),
              SizedBox(height: 8),
              Text('Stock Quantity: ${product.stockQuantity}'),
              SizedBox(height: 8),
              Text('Backordered: ${product.backordered ? 'Yes' : 'No'}'),
              SizedBox(height: 8),
              Text(
                  'Supplier: ${product.supplierId.firstName} ${product.supplierId.lastName}'),
              SizedBox(height: 8),
              Text('Manufacturer ID: ${product.manufacturerId}'),
              SizedBox(height: 8),
              Text('Manufacturer Name: ${product.manufacturerName}'),
              SizedBox(height: 8),
              Text('Item Source: ${product.itemSource}'),
              SizedBox(height: 8),
              Text('Quantity Sold: ${product.quantitySold}'),
              SizedBox(height: 8),
              Text('Quantity in Stock: ${product.quantityInStock}'),
            ],
          ),
        ),
      ),
    );
  }
}
