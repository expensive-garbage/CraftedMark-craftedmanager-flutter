class OrderedItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final double discount;
  final String description;

  OrderedItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.description,
  });

  factory OrderedItem.fromMap(Map<String, dynamic> map) {
    return OrderedItem(
      id: map['ordered_item_id'] ?? 0,
      orderId: map['order_id'] ?? 0,
      productId: map['product_id'] ?? 0,
      quantity: map['quantity'] ?? 0,
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
      discount: double.tryParse(map['discount']?.toString() ?? '0') ?? 0.0,
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ordered_item_id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'discount': discount,
      'description': description,
    };
  }
}
