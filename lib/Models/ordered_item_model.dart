class OrderedItem {
  int id;
  int orderId;
  String productName;
  int productId;
  String name;
  int quantity;
  double price;
  double discount;
  String productDescription;
  double productRetailPrice;
  String status;

  OrderedItem copyWith({
    int? id,
    int? orderId,
    String? productName,
    int? productId,
    String? name,
    int? quantity,
    double? price,
    double? discount,
    String? productDescription,
    double? productRetailPrice,
    String? status,
  }) {
    return OrderedItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      productDescription: productDescription ?? this.productDescription,
      productRetailPrice: productRetailPrice ?? this.productRetailPrice,
      status: status ?? this.status,
    );
  }

  OrderedItem({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.productDescription,
    required this.productRetailPrice,
    required this.status,
  });

  // // Add the setter for quantity
  // set quantity(int newQuantity) {
  //   this.quantity = newQuantity;
  // }

  factory OrderedItem.fromMap(Map<String, dynamic> map) {
    num parseNum(dynamic value) {
      if (value is num) {
        return value;
      } else {
        try {
          return num.parse(value);
        } catch (_) {
          return 0;
        }
      }
    }

    return OrderedItem(
      id: map['ordered_item_id'] as int,
      orderId: map['order_id'] as int,
      productName: map['product_name'] as String? ?? 'Unknown',
      productId: map['product_id'] as int,
      name: map['name'] as String? ?? 'Unknown',
      quantity: map['quantity'] as int,
      price: parseNum(map['price']).toDouble(),
      discount: parseNum(map['discount']).toDouble(),
      productDescription: map['description'] as String? ?? '',
      // Add the null check and default value here
      productRetailPrice: parseNum(map['retail_price']).toDouble(),
      status: map['status'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ordered_item_id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name': name,
      'quantity': quantity,
      'price': price,
      'discount': discount,
      'description': productDescription,
      'retail_price': productRetailPrice,
      'status': status,
    };
  }

// // Add a setter for the 'price' field
//   set price(double newPrice) {
//     this.price = newPrice;
//   }
}
