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
    DateTime parseOrderDate(String date) {
      try {
        return DateTime.parse(date);
      } catch (_) {
        return DateTime.now(); // Return a default date value when parsing fails
      }
    }

    return Order(
      id: int.parse(map['order_id'].toString()),
      customerId: map['people_id'].toString(),
      orderDate: parseOrderDate(map['orderDate'].toString()),
      // Use the parseOrderDate function here
      shippingAddress: map['shipping_address'] ?? '',
      billingAddress: map['billing_address'] ?? '',
      totalAmount:
          double.tryParse(map['total_amount']?.toString() ?? '0') ?? 0.0,
      orderStatus: map['order_status'] ?? '',
    );
  }
}
