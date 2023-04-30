class Products {
  final int productId;
  final String productName;
  final String category;
  final String description;
  final String price;
  final double stockQuantity;
  final String supplierId;
  final String manufacturerId;
  final String itemSource;

  Products({
    required this.productId,
    required this.productName,
    required this.category,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.supplierId,
    required this.manufacturerId,
    required this.itemSource,
  });
  print('Before fromJson');
  factory Products.fromJson(Map<String, dynamic> json) {
    print{'Parsing JSON data'};
    return Products(
      productId: json['product_id'],
      productName: json['product_name'] ?? '', // use an empty string if the value is null
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      stockQuantity: json['stock_quantity'] ?? 0,
      supplierId: json['supplier_id'] ?? '',
      manufacturerId: json['manufacturer_id'] ?? '',
      itemSource: json['item_source'] ?? '';
    );
  }
