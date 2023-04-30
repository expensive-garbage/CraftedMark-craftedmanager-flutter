class Products {
  final String productId;
  final String productName;
  final String category;
  final String description;
  final String price;
  final int stockQuantity;
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

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      productId: json['product_id'],
      productName: json['product_name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      stockQuantity: json['stock_quantity'] ?? 0,
      supplierId: json['supplier_id'] ?? '',
      manufacturerId: json['manufacturer_id'] ?? '',
      itemSource: json['item_source'] ?? '',
    );
  }
}
