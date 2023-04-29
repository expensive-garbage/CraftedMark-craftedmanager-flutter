import 'package:flutter/cupertino.dart';

class ContactDetailWidget extends StatefulWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String email;
  final String brand;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String zip;
  final bool customerBasedPricing;
  final String accountNumber;
  final String type;
  final String notes;
  final DateTime? createdDate;
  final String createdBy;
  final DateTime? updatedDate;
  final String updatedBy;

  ContactDetailWidget({
    Key? key,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.brand,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.zip,
    required this.customerBasedPricing,
    required this.accountNumber,
    required this.type,
    required this.notes,
    required this.createdDate,
    required this.createdBy,
    required this.updatedDate,
    required this.updatedBy,
  }) : super(key: key);

  @override
  _ContactDetailWidgetState createState() => _ContactDetailWidgetState();
}

class _ContactDetailWidgetState extends State<ContactDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.firstname} ${widget.lastname}'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 24),
            Text(
              '${widget.firstname} ${widget.lastname}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            _buildContactActionRow('Phone', widget.phone, Icon(CupertinoIcons.phone)),
            SizedBox(height: 8),
            _buildContactActionRow('Email', widget.email, Icon(CupertinoIcons.mail)),
            SizedBox(height: 24),
            _buildAddressSection(),
            SizedBox(height: 24),
            _buildDetailSection(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContactActionRow(String label, String value, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 12),
              Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 8),
        _buildInfoRow('${widget.address1}, ${widget.address2}, ${widget.city}, ${widget.state} ${widget.zip}'),
      ],
    );
  }

  Widget _buildDetailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 8),
        _buildInfoRow('Brand: ${widget.brand}'),
        _buildInfoRow('Account Number: ${widget.accountNumber}'),
        _buildInfoRow('Type: ${widget.type}'),
        _buildInfoRow('Customer-Based Pricing: ${widget.customerBasedPricing}'),
        _buildInfoRow('Notes: ${widget.notes}'),
      ],
    );
  }

  Widget _buildInfoRow(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}