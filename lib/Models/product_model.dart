class Product {
  final int id;
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

  Product.empty()
      : id = 0,
        // Changed from '' to 0
        name = '',
        category = '',
        subCategory = '',
        subcat2 = '',
        flavor = '',
        description = '',
        costOfGood = 0,
        manufacturingPrice = 0,
        wholesalePrice = 0,
        retailPrice = 0,
        stockQuantity = 0,
        backordered = false,
        supplier = '',
        manufacturerId = '',
        // Added empty initialization
        manufacturerName = '',
        itemSource = '',
        quantitySold = 0,
        quantityInStock = 0;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.subcat2,
    required this.flavor,
    required this.description,
    required this.costOfGood,
    required this.manufacturingPrice,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.stockQuantity,
    required this.backordered,
    required this.supplier, // Changed from "Supplier" to "String"
    required this.manufacturerId,
    required this.manufacturerName,
    required this.itemSource,
    required this.quantitySold,
    required this.quantityInStock,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['product_id'] ?? 0,
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
      // Updated this line
      backordered: map['backordered'] ?? false,
      manufacturerName: map['manufacturer_name'] ?? '',
      supplier: map['supplier_name'] ?? '',
      manufacturerId: map['manufacturer_id'] ?? '',
      // Added this line
      itemSource: map['item_source'] ?? '',
      quantitySold: map['quantity_sold'] ?? 0,
      quantityInStock: map['quantity_in_stock'] ?? 0,
    );
  }
}
