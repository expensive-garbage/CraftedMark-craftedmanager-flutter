class People {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String brand;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? zip;
  final bool customerBasedPricing;
  final String? accountNumber;
  final String type;
  final String? notes;
  final DateTime createdDate;
  final String? createdBy;
  final DateTime updatedDate;
  final String? updatedBy;

  People({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.brand,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    required this.customerBasedPricing,
    this.accountNumber,
    required this.type,
    this.notes,
    required this.createdDate,
    required this.createdBy,
    required this.updatedDate,
    required this.updatedBy,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      id: json['id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      phone: json['phone'],
      email: json['email'],
      brand: json['brand'],
      address1: json['address1'],
      address2: json['address2'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      customerBasedPricing: json['customerbasedpricing'],
      accountNumber: json['accountnumber'],
      type: json['type'],
      notes: json['notes'],
      createdDate: DateTime.parse(json['createddate']),
      createdBy: json['createdby'],
      updatedDate: DateTime.parse(json['updateddate']),
      updatedBy: json['updatedby'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'phone': phone,
      'email': email,
      'brand': brand,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'zip': zip,
      'customerbasedpricing': customerBasedPricing,
      'accountnumber': accountNumber,
      'type': type,
      'notes': notes,
      'createddate': createdDate.toIso8601String(),
      'createdby': createdBy,
      'updateddate': updatedDate.toIso8601String(),
      'updatedby': updatedBy,
    };
  }
}
