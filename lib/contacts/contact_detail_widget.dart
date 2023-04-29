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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('ID', '${widget.id}'),
                _buildInfoRow('First Name', widget.firstname),
                _buildInfoRow('Last Name', widget.lastname),
                _buildInfoRow('Phone', widget.phone),
                if (widget.email != null) _buildInfoRow('Email', widget.email!),
                if (widget.brand != null) _buildInfoRow('Brand', widget.brand!),
                if (widget.address1 != null) _buildInfoRow('Address 1', widget.address1!),
                if (widget.address2 != null) _buildInfoRow('Address 2', widget.address2!),
                if (widget.city != null) _buildInfoRow('City', widget.city!),
                if (widget.state != null) _buildInfoRow('State', widget.state!),
                if (widget.zip != null) _buildInfoRow('ZIP', widget.zip!),
                if (widget.customerBasedPricing != null) _buildInfoRow('Customer-Based Pricing', widget.customerBasedPricing!.toString()),
                if (widget.accountNumber != null) _buildInfoRow('Account Number', widget.accountNumber!),
                if (widget.type != null) _buildInfoRow('Type', widget.type!),
                if (widget.notes != null) _buildInfoRow('Notes', widget.notes!),
                _buildInfoRow('Created Date', '${widget.createdDate}'),
                _buildInfoRow('Created By', widget.createdBy),
                _buildInfoRow('Updated Date', '${widget.updatedDate}'),
                _buildInfoRow('Updated By', widget.updatedBy),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}