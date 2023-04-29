import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
	bool customerBasedPricing;
	final String accountNumber;
	final String type;
	final String notes;
	final DateTime createdDate;
	final String createdBy;
	final DateTime updatedDate;
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
	bool _isEditing = false;

	final TextEditingController _phoneController = TextEditingController();
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _address1Controller = TextEditingController();
	final TextEditingController _address2Controller = TextEditingController();
	final TextEditingController _cityController = TextEditingController();
	final TextEditingController _stateController = TextEditingController();
	final TextEditingController _zipController = TextEditingController();
	final TextEditingController _accountNumberController = TextEditingController();
	final TextEditingController _typeController = TextEditingController();
	final TextEditingController _notesController = TextEditingController();

	// Options for the Type picker
	final List<String> _typeOptions = [
		'Customer',
		'Supplier',
		'Vendor',
		'Employee',
		'Prospect'
	];
	int _selectedTypeOptionIndex = 0;

	@override
	void initState() {
		super.initState();
		_phoneController.text = widget.phone;
		_emailController.text = widget.email;
		_address1Controller.text = widget.address1;
		_address2Controller.text = widget.address2;
		_cityController.text = widget.city;
		_stateController.text = widget.state;
		_zipController.text = widget.zip;
		_accountNumberController.text = widget.accountNumber;
		_typeController.text = widget.type;
		_notesController.text = widget.notes;
	}

	@override
	void dispose() {
		_phoneController.dispose();
		_emailController.dispose();
		_address1Controller.dispose();
		_address2Controller.dispose();
		_cityController.dispose();
		_stateController.dispose();
		_zipController.dispose();
		_accountNumberController.dispose();
		_typeController.dispose();
		_notesController.dispose();
		super.dispose();
	}

	void _updateContact() {
		// Perform the database update here, using the TextEditingController objects
		// to get the updated values
		// e.g. _phoneController.text, _emailController.text, etc.
	}

	@override
	Widget build(BuildContext context) {
		return CupertinoPageScaffold(
			navigationBar: CupertinoNavigationBar(
				middle: Text('${widget.firstname} ${widget.lastname}'),
				trailing: GestureDetector(
					onTap: () {
						if (_isEditing) {
							_updateContact();
						}
						setState(() {
							_isEditing = !_isEditing;
						});
					},
					child: Text(
						_isEditing ? 'Save' : 'Edit',
						style: const TextStyle(
							color: CupertinoColors.activeBlue,
							fontWeight: FontWeight.w600,
						),
					),
				),
			),
			child: ListView(
				children: [
					// ...
					CupertinoFormSection.insetGrouped(
						header: const Text('Additional Information',
								style: TextStyle(fontWeight: FontWeight.bold)),
						children: [
							CupertinoFormRow(
								prefix: const Text('Customer Based Pricing:',
										style: TextStyle(fontWeight: FontWeight.bold)),
								child: !_isEditing
										? Text(widget.customerBasedPricing ? 'Yes' : 'No')
										: CupertinoSwitch(
									value: widget.customerBasedPricing,
									onChanged: _isEditing ? (bool value) {
										setState(() {
											widget.customerBasedPricing = value;
										});
									} : null,
								),
							),
							GestureDetector(
								onTap: () {
									if (_isEditing) {
										showModalBottomSheet(
											context: context,
											builder: (BuildContext context) {
												return CupertinoPicker(
													itemExtent: 32.0,
													onSelectedItemChanged: (int index) {
														setState(() {
															_typeController.text = _typeOptions[index];
														});
													},
													children: List<Widget>.generate(_typeOptions.length, (
															int index) {
														return Center(
															child: Text(_typeOptions[index]),
														);
													}),
												);
											},
										);
									}
								},
								child: CupertinoTextFormFieldRow(
									controller: _typeController,
									readOnly: !_isEditing,
									prefix: const Text(
											'Type:', style: TextStyle(fontWeight: FontWeight.bold)),
								),
							),
							CupertinoTextFormFieldRow(
								controller: _notesController,
								readOnly: !_isEditing,
								prefix: const Text(
										'Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
							),
						],
					),
					// ...
				],
			),
		);
	}
}