import 'package:uuid/uuid.dart' show Uuid;

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final int stock;
  final double costPerUnit;
  final String size;
  final String type;

  Product({
    String? id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.costPerUnit,
    required this.size,
    required this.type,
  }) : id = id ?? const Uuid().v4();

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      stock: json['stock'],
      costPerUnit: json['costPerUnit'],
      size: json['size'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'stock': stock,
      'costPerUnit': costPerUnit,
      'size': size,
      'type': type,
    };
  }
}
