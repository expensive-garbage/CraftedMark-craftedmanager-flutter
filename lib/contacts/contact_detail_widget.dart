import 'package:flutter/cupertino.dart';

class ContactDetailWidget extends StatefulWidget {
  final String id;
  final String? firstname;
  final String? lastname;
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

  const ContactDetailWidget({
    Key? key,
    required this.id,
    this.firstname,
    this.lastname,
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
  _ContactDetailWidgetState createState() => ContactDetailWidgetState();
}

class _ContactDetailWidgetState extends State<ContactDetailWidget> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.firstname ?? ''} ${widget.lastname ?? ''}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(_editing ? 'Save' : 'Edit'),
          onPressed: () {
            setState(() {
              _editing = !_editing;
            });
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoFormSection(
                  header: const Text('Basic Information'),
                  children: [
                    _buildFormRow('First Name', widget.firstname),
                    _buildFormRow('Last Name', widget.lastname),
                    _buildFormRow('Phone', widget.phone),
                    _buildFormRow('Email', widget.email),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text('Address'),
                  children: [
                    _buildFormRow('Address 1', widget.address1),
                    _buildFormRow('Address 2', widget.address2),
                    _buildFormRow('City', widget.city),
                    _buildFormRow('State', widget.state),
                    _buildFormRow('ZIP', widget.zip),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text('Additional Information'),
                  children: [
                    _buildFormRow('Brand', widget.brand),
                    _buildFormRow('Account Number', widget.accountNumber),
                    _buildFormRow('Type', widget.type),
                    _buildFormRowWithSwitch(
                        'Customer-Based Pricing', widget.customerBasedPricing),
                    _buildFormRow('Notes', widget.notes),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildFormRow(String label, String? value) {
    return CupertinoFormRow(
      prefix: SizedBox(
        width: 150,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      child: _editing
          ? CupertinoTextFormFieldRow(
        initialValue: value ?? '',
        onChanged: (newValue) {},
      )
          : Text(value ?? 'N/A'),
    );
  }


  Widget _buildFormRowWithSwitch(String label, bool value) {
    return CupertinoFormRow(
      prefix: SizedBox(
        width: 150,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      child: _editing
          ? CupertinoSwitch(
        value: value,
        onChanged: (newValue) {},
      )
          : Text(value ? 'Yes' : 'No'),
    );
  }
}
