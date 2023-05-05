
class Order {
  int id;
  String customerId;
  DateTime orderDate;
  String shippingAddress;
  String billingAddress;
  double totalAmount;
  String orderStatus;

  Order({
    required this.id,
    required this.customerId,
    required this.orderDate,
    required this.shippingAddress,
    required this.billingAddress,
    required this.totalAmount,
    required this.orderStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
      'shippingAddress': shippingAddress,
      'billingAddress': billingAddress,
      'totalAmount': totalAmount,
      'orderStatus': orderStatus,
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      customerId: map['customerId'],
      orderDate: DateTime.parse(map['orderDate']),
      shippingAddress: map['shippingAddress'],
      billingAddress: map['billingAddress'],
      totalAmount: map['totalAmount'],
      orderStatus: map['orderStatus'],
    );
  }
}

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
