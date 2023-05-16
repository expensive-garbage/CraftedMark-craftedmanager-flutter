class OrderedItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final double discount;
  final String productDescription;
  final double productRetailPrice;

  OrderedItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.productDescription,
    required this.productRetailPrice,
  });

  // Add the setter for quantity
  set quantity(int newQuantity) {
    this.quantity = newQuantity;
  }

  factory OrderedItem.fromMap(Map<String, dynamic> map) {
    return OrderedItem(
      id: map['ordered_item_id'] ?? 0,
      orderId: map['order_id'] ?? 0,
      productId: map['product_id'] ?? 0,
      quantity: map['quantity'] ?? 0,
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
      discount: double.tryParse(map['discount']?.toString() ?? '0') ?? 0.0,
      productDescription: map['description'] ?? '',
      productRetailPrice:
          double.tryParse(map['retail_price']?.toString() ?? '0') ?? 0.0,
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
      'description': productDescription,
      'retail_price': productRetailPrice,
    };
  }
}
