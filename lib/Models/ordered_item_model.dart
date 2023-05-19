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
      id: map['ordered_item_id'] as int,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      price: (map['price'] as num).toDouble(),
      discount: (map['discount'] as num).toDouble(),
      productDescription: map['description'] as String,
      productRetailPrice: (map['retail_price'] as num).toDouble(),
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
