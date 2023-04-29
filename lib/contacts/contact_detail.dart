import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/contacts/lib/postgres.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  ContactsListState createState() => ContactsListState();
}

class ContactsListState extends State<ContactsList> {
  List<Map<String, dynamic>>? _contacts;

  @override
  void initState() {
    super.initState();
    fetchData('people').then((contacts) {
      setState(() {
        _contacts = contacts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Contacts'),
      ),
      child: _contacts == null
          ? const Center(child: CupertinoActivityIndicator())
          : ListView.separated(
        itemCount: _contacts!.length,
        itemBuilder: (context, index) {
          final contact = _contacts![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ContactDetail(
                    id: contact['id'],
                    firstname: contact['firstname'],
                    lastname: contact['lastname'],
                    phone: contact['phone'],
                    email: contact['email'],
                    address1: contact['address1'],
                    address2: contact['address2'],
                    city: contact['city'],
                    state: contact['state'],
                    zip: contact['zip'],
                    customerBasedPricing: contact['customerbasedpricing'],
                    accountNumber: contact['accountnumber'],
                    type: contact['type'],
                    notes: contact['notes'],
                    createdDate: contact['createddate'].toString(), // convert to string
                    createdBy: contact['createdby'],
                    updatedDate: contact['updateddate'].toString(), // convert to string
                    updatedBy: contact['updatedby'],
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${contact['firstname']} ${contact['lastname']}'),
                if (contact.containsKey('brand'))
                  Text(contact['brand']),
                Text(contact['phone']),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          color: CupertinoColors.systemGrey4,
          thickness: 0.5,
          height: 1,
        ),
      ),
    );
  }
}