class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final String price;
  final int stockQuantity;
  final Supplier supplier;
  final String manufacturerId;
  final String itemSource;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.supplier,
    required this.manufacturerId,
    required this.itemSource,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toString() ?? '',
      stockQuantity: (map['stock_quantity'] ?? 0).toInt(),
      supplier: Supplier.fromMap(map['supplier']),
      manufacturerId: map['manufacturer_id']?.toString() ?? '',
      itemSource: map['item_source'] ?? '',
    );
  }
}

class Supplier {
  final String id;
  final String name;

  Supplier({
    required this.id,
    required this.name,
  });

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
    );
  }
}
