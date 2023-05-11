import 'people_model.dart';

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
  final double stockQuantity;
  final bool backordered;
  final People supplierId;
  final String manufacturerId;
  final String manufacturerName;
  final String itemSource;
  final int quantitySold;
  final int quantityInStock;

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
    required this.supplierId,
    required this.manufacturerId,
    required this.manufacturerName,
    required this.itemSource,
    required this.quantitySold,
    required this.quantityInStock,
  });

  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? subCategory,
    String? subcat2,
    String? flavor,
    String? description,
    double? costOfGood,
    double? manufacturingPrice,
    double? wholesalePrice,
    double? retailPrice,
    double? stockQuantity,
    bool? backordered,
    People? supplierId,
    String? manufacturerId,
    String? manufacturerName,
    String? itemSource,
    int? quantitySold,
    int? quantityInStock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      subcat2: subcat2 ?? this.subcat2,
      flavor: flavor ?? this.flavor,
      description: description ?? this.description,
      costOfGood: costOfGood ?? this.costOfGood,
      manufacturingPrice: manufacturingPrice ?? this.manufacturingPrice,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      retailPrice: retailPrice ?? this.retailPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      backordered: backordered ?? this.backordered,
      supplierId: supplierId ?? this.supplierId,
      manufacturerId: manufacturerId ?? this.manufacturerId,
      manufacturerName: manufacturerName ?? this.manufacturerName,
      itemSource: itemSource ?? this.itemSource,
      quantitySold: quantitySold ?? this.quantitySold,
      quantityInStock: quantityInStock ?? this.quantityInStock,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
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
      stockQuantity: map['stock_quantity']?.toDouble() ?? 0.0,
      backordered: map['backordered'] ?? false,
      supplierId: map['supplierId'] != null
          ? People.fromMap(map['supplierId'])
          : People(
              id: '',
              firstName: '',
              lastName: '',
              email: '',
              phone: '',
              brand: '',
              address1: '',
              address2: null,
              city: '',
              state: '',
              zip: '',
              notes: '',
            ),
      manufacturerId: map['manufacturer_id']?.toString() ?? '',
      manufacturerName: map['manufacturer_name'] ?? '',
      itemSource: map['item_source'] ?? '',
      quantitySold: map['quantity_sold'] ?? 0,
      quantityInStock: map['quantity_in_stock'] ?? 0,
    );
  }
}
