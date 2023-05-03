class People {
  final int id;
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
  final String notes;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? updatedDate;
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
    required this.notes,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
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
      address2: json['address2'] == null ? '' : json['address2'].toString(),
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      customerBasedPricing: json['customerbasedpricing'] == null ? null : json['customerbasedpricing'],
      accountNumber: json['accountnumber'],
      type: json['type'],
      notes: json['notes'],
      createdDate: json['createddate'] == null ? null : DateTime.parse(json['createddate']),
      createdBy: json['created_by'] ?? 'Unknown',
      updatedDate: json['updateddate'] == null ? null : DateTime.parse(json['updateddate']),
      updatedBy: json['updated_by'] ?? 'Unknown',
    );
  }
}
