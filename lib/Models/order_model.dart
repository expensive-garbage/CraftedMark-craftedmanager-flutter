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

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['order_id'],
      customerId: map['people_id'],
      orderDate: map['order_date'],
      shippingAddress: map['shipping_address'] ?? '',
      billingAddress: map['billing_address'] ?? '',
      totalAmount:
          double.tryParse(map['total_amount']?.toString() ?? '0') ?? 0.0,
      orderStatus: map['order_status'] ?? '',
    );
  }
}
