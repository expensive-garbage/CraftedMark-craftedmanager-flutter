class Order {
  int id;
  String customerId;
  DateTime orderDate;
  String shippingAddress;
  String billingAddress;
  double totalAmount;
  String orderStatus;
  String productName;

  //String firstName; // added new field
  //String lastName; // added new field

  Order copyWith({
    int? id,
    String? customerId,
    DateTime? orderDate,
    String? shippingAddress,
    String? billingAddress,
    double? totalAmount,
    String? orderStatus,
    String? productName,
    //String? firstName, // added new parameter
    //String? lastName, // added new parameter
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      orderDate: orderDate ?? this.orderDate,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      totalAmount: totalAmount ?? this.totalAmount,
      orderStatus: orderStatus ?? this.orderStatus,
      productName: productName ?? this.productName,
      //firstName: firstName ?? this.firstName, // added new field
      //lastName: lastName ?? this.lastName, // added new field
    );
  }

  Order({
    required this.id,
    required this.customerId,
    required this.orderDate,
    required this.shippingAddress,
    required this.billingAddress,
    required this.totalAmount,
    required this.orderStatus,
    required this.productName,
    //required this.firstName, // added new parameter
    //required this.lastName, // added new parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': id,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
      'shippingAddress': shippingAddress,
      'billingAddress': billingAddress,
      'totalAmount': totalAmount,
      'orderStatus': orderStatus,
      'productName': productName,
      //'firstName': firstName, // added new field
      //'lastName': lastName, // added new field
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
      shippingAddress: map['shipping_address'] ?? '',
      billingAddress: map['billing_address'] ?? '',
      totalAmount:
          double.tryParse(map['total_amount']?.toString() ?? '0') ?? 0.0,
      orderStatus: map['order_status'] ?? '',
      productName: map['product_name'] ?? '',
      //firstName: map['first_name'] ?? '', // added new field
      //lastName: map['last_name'] ?? '', // added new field
    );
  }
}
