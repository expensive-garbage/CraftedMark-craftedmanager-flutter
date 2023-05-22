import 'package:crafted_manager/Contacts/people_db_manager.dart';
import 'package:crafted_manager/Extension/iterable_extension.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:flutter/cupertino.dart';

class ContactDetailWidget extends StatefulWidget {
  final People initialValue;

  const ContactDetailWidget(
    this.initialValue, {
    Key? key,
  }) : super(key: key);

  @override
  State<ContactDetailWidget> createState() => _ContactDetailWidgetState();
}

class _ContactDetailWidgetState extends State<ContactDetailWidget> {
  bool _editing = false;
  late People value;

  @override
  void initState() {
    value = widget.initialValue;
    if (value.id <= 0) {
      _editing = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: Text('${value.firstName} ${value.lastName}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(_editing ? 'Save' : 'Edit'),
          onPressed: () async {
            if (!_editing) {
              setState(() => _editing = true);
            } else {
              People? updatedContact;
              if (value.id <= 0) {
                await PeoplePostgres.createCustomer(value);
                updatedContact = (await PeoplePostgres.fetchCustomersByDetails(
                        value.firstName, value.lastName, value.phone))
                    .firstWhere((element) => element.id > 0, // Change this line
                        orElse: () => People.empty());
              } else {
                updatedContact = (await PeoplePostgres.fetchCustomersByDetails(
                        value.firstName, value.lastName, value.phone))
                    .firstOrNull;
              }

              if (updatedContact != null && updatedContact.id > 0) {
                setState(() => _editing = false);
                Navigator.pop(context, updatedContact);
              } else {
                await PeoplePostgres.updateCustomer(value);
              }
              setState(() => _editing = false);
            }
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
                    _buildFormRow('First Name', value.firstName,
                        (n) => value = value.copyWith(firstName: n)),
                    _buildFormRow('Last Name', value.lastName,
                        (n) => value = value.copyWith(lastName: n)),
                    _buildFormRow('Phone', value.phone,
                        (n) => value = value.copyWith(phone: n)),
                    _buildFormRow('Email', value.email,
                        (n) => value = value.copyWith(email: n)),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text('Address'),
                  children: [
                    _buildFormRow('Address 1', value.address1,
                        (n) => value = value.copyWith(address1: n)),
                    _buildFormRow('Address 2', value.address2,
                        (n) => value = value.copyWith(address2: n)),
                    _buildFormRow('City', value.city,
                        (n) => value = value.copyWith(city: n)),
                    _buildFormRow('State', value.state,
                        (n) => value = value.copyWith(state: n)),
                    _buildFormRow('ZIP', value.zip,
                        (n) => value = value.copyWith(zip: n)),
                  ],
                ),
                CupertinoFormSection(
                  header: const Text('Additional Information'),
                  children: [
                    _buildFormRow('Brand', value.brand,
                        (n) => value = value.copyWith(brand: n)),
                    _buildFormRow('Account Number', value.accountNumber,
                        (n) => value = value.copyWith(accountNumber: n)),
                    _buildFormRow('Type', value.type,
                        (n) => value = value.copyWith(type: n)),
                    _buildFormRowWithSwitch(
                        'Customer-Based Pricing',
                        value.customerBasedPricing ?? false,
                        (n) => value = value.copyWith(customerBasedPricing: n)),
                    _buildFormRow('Notes', value.notes,
                        (n) => value = value.copyWith(notes: n)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormRow(
      String label, String? value, void Function(String) setter) {
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
              onChanged: setter,
            )
          : Text(value ?? 'N/A'),
    );
  }

  Widget _buildFormRowWithSwitch(
      String label, bool value, void Function(bool) setter) {
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
              onChanged: setter,
            )
          : Text(value ? 'Yes' : 'No'),
    );
  }
}
