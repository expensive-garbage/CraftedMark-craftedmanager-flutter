class OrderedItem {
  int id;
  int orderId;
  int productId;
  int quantity;
  double price;
  double discount;

  OrderedItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.discount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'discount': discount,
    };
  }

  static OrderedItem fromMap(Map<String, dynamic> map) {
    return OrderedItem(
      id: map['id'],
      orderId: map['orderId'],
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
      discount: map['discount'],
    );
  }
}
