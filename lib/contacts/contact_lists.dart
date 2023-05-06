import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contact_detail_widget.dart';
import 'package:crafted_manager/postgres.dart';

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
      child: Material(
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
                    builder: (context) =>
                        ContactDetailWidget(
                          id: contact['id'],
                          firstname: contact['firstname'],
                          lastname: contact['lastname'],
                          phone: contact['phone'],
                          email: contact['email'],
                          brand: contact['brand'],
                          address1: contact['address1'],
                          address2: contact['address2'] ?? 'N/A',
                          city: contact['city'],
                          state: contact['state'],
                          zip: contact['zip'],
                          customerBasedPricing: contact['customerbasedpricing'],
                          accountNumber: contact['accountnumber'],
                          type: contact['type'],
                          notes: contact['notes'],
                          createdDate: contact['createddate'],
                          createdBy: contact['createdby'] ?? 'N/A',
                          updatedDate: contact['updateddate'],
                          updatedBy: contact['updatedby'] ?? 'N/A',
                        ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                    '${contact['firstname'] ?? ''} ${contact['lastname'] ??
                        ''}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (contact.containsKey('brand'))
                      Text(contact['brand'] ?? 'N/A'),
                    Text(contact['phone'] ?? 'N/A'),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) =>
          const Divider(
            thickness: 0.5,
            height: 1,
          ),
        ),
      ),
    );
  }
}
