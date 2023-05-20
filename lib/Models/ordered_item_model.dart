class OrderedItem {
  final int id;
  final int orderId;
  final String productName;
  final int productId;
  final String name;
  final int quantity;
  final double price;
  final double discount;
  final String productDescription;
  final double productRetailPrice;

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
  });

  // Add the setter for quantity
  set quantity(int newQuantity) {
    this.quantity = newQuantity;
  }

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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ordered_item_id': id,
      'order_id': orderId,
      'product_id': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discount': discount,
      'description': productDescription,
      'retail_price': productRetailPrice,
    };
  }
}
