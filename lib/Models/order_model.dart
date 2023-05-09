class Order {
  int id;
  int customerId;
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
      id: map['id'],
      customerId: map['customer_id'],
      orderDate: DateTime.tryParse(map['order_date']?.toString() ?? '') ??
          DateTime.now(),
      shippingAddress: map['shipping_address'] ?? '',
      billingAddress: map['billing_address'] ?? '',
      totalAmount:
          double.tryParse(map['total_amount']?.toString() ?? '0') ?? 0.0,
      orderStatus: map['order_status'] ?? '',
    );
  }
}
