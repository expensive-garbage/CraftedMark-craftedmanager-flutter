class Product {
  final int id;
  final String name;
  final double price;
  final String supplier;

  Product({required this.id, required this.name, required this.price, required this.supplier});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'].toDouble(),
      supplier: map['supplier'],
    );
  }
}
