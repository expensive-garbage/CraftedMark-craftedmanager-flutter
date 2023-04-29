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
  final bool? customerBasedPricing;
  final String? accountNumber;
  final String? type;
  final String? notes;
  final String createdDate;
  final String? createdBy;
  final String updatedDate;
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
    this.customerBasedPricing,
    this.accountNumber,
    this.type,
    this.notes,
    required this.createdDate,
    this.createdBy,
    required this.updatedDate,
    this.updatedBy,
  });

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'],
      brand: map['brand'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      state: map['state'],
      zip: map['zip'],
      customerBasedPricing: map['customerbasedpricing'],
      accountNumber: map['accountnumber'],
      type: map['type'],
      notes: map['notes'],
      createdDate: DateTime (map['createddate']),
      createdBy: map['createdby'],
      updatedDate: DateTime (map['updateddate']),
      updatedBy: map['updatedby'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
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
