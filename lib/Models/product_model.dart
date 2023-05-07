import 'people_model.dart';



class Product {
  final int id; // Change the data type to int
  final String name;
  final String category;
  final String subCategory;
  final String subcat2;
  final String flavor;
  final String description;
  final double costOfGood;
  final double manufacturingPrice;
  final double wholesalePrice;
  final double retailPrice; // Change the data type to double
  final int stockQuantity;
  final bool backordered;
  final People supplier;
  final int manufacturerId; // Change the data type to int
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
    required this.supplier,
    required this.manufacturerId,
    required this.manufacturerName,
    required this.itemSource,
    required this.quantitySold,
    required this.quantityInStock,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      subCategory: map['sub_category'],
      subcat2: map['subcat2'],
      flavor: map['flavor'],
      description: map['description'],
      costOfGood: map['cost_of_good'],
      manufacturingPrice: map['manufacturing_price'],
      wholesalePrice: map['wholesale_price'],
      retailPrice: map['retail_price'],
      stockQuantity: map['stock_quantity'],
      backordered: map['backordered'],
      supplier: People.fromMap(map['supplier']),
      manufacturerId: map['manufacturer_id'],
      manufacturerName: map['manufacturer_name'],
      itemSource: map['item_source'],
      quantitySold: map['quantity_sold'],
      quantityInStock: map['quantity_in_stock'],
    );
  }
}
