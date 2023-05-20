class Product {
  final int? id;
  final String name;
  final String category;
  final String subCategory;
  final String subcat2;
  final String flavor;
  final String description;
  final double costOfGood;
  final double manufacturingPrice;
  final double wholesalePrice;
  final double retailPrice;
  final int stockQuantity;
  final bool backordered;
  final String supplier;
  final String manufacturerId;
  final String manufacturerName;
  final String itemSource;
  final int quantitySold;
  final int quantityInStock;

  Product({
    this.id,
    required this.name,
    this.category = '',
    this.subCategory = '',
    this.subcat2 = '',
    this.flavor = '',
    this.description = '',
    this.costOfGood = 0,
    this.manufacturingPrice = 0,
    this.wholesalePrice = 0,
    required this.retailPrice,
    this.stockQuantity = 0,
    this.backordered = false,
    this.supplier = '',
    this.manufacturerId = '',
    this.manufacturerName = '',
    this.itemSource = '',
    this.quantitySold = 0,
    this.quantityInStock = 0,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['product_id'] as int?,
      name: map['product_name'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['sub_category'] ?? '',
      subcat2: map['subcat2'] ?? '',
      flavor: map['flavor'] ?? '',
      description: map['description'] ?? '',
      costOfGood:
          map['cost_of_good'] != null ? double.parse(map['cost_of_good']) : 0.0,
      manufacturingPrice: map['manufacturing_price'] != null
          ? double.parse(map['manufacturing_price'])
          : 0.0,
      wholesalePrice: map['wholesale_price'] != null
          ? double.parse(map['wholesale_price'])
          : 0.0,
      retailPrice:
          map['retail_price'] != null ? double.parse(map['retail_price']) : 0.0,
      stockQuantity:
          map['stock_quantity'] != null ? map['stock_quantity'].round() : 0,
      backordered: map['backordered'] ?? false,
      supplier: map['supplier'] ?? '',
      manufacturerId: map['manufacturer_id'] ?? '',
      manufacturerName: map['manufacturer_name'] ?? '',
      itemSource: map['item_source'] ?? '',
      quantitySold: map['quantity_sold'] ?? 0,
      quantityInStock: map['quantity_in_stock'] ?? 0,
    );
  }
}
