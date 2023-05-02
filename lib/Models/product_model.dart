
class People {
  final String id;
  final String firstName;
  final String lastName;
  final String type;

  People({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.type,
  });

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      type: map['type'],
    );
  }

  String get fullName => '$firstName $lastName';
}


class Product {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final String subcat2;
  final String flavor;
  final String description;
  final double costOfGood;
  final double manufacturingPrice;
  final double wholesalePrice;
  final String retailPrice;
  final int stockQuantity;
  final bool backordered;
  final People supplier;
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
