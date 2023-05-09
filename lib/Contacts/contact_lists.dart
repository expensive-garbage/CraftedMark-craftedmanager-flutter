import 'package:crafted_manager/Contacts/people_postgres.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/people_model.dart';
import 'contact_detail_widget.dart';
import 'package:crafted_manager/postgres.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  ContactsListState createState() => ContactsListState();
}

class ContactsListState extends State<ContactsList> {
  List<People>? _contacts;

  @override
  void initState() {
    super.initState();
    fetchData('people').then((contacts) {
      setState(() {
        _contacts = contacts.map((e) => People.fromMap(e)).toList();
      });
    });
  }

  Future<void> openContactDetails(People contact) async {
    print(contact.id);
    final updatedContact = await Navigator.push<People>(
      context,
      CupertinoPageRoute(
        builder: (context) => ContactDetailWidget(contact),
      ),
    );
    if (updatedContact is People) {
      final index = _contacts?.indexWhere((e) => e.id == updatedContact.id);
      if (index != null && index >= 0) {
        setState(() {
          _contacts?[index] = updatedContact;
        });
      }
      await PeoplePostgres.updateCustomer(updatedContact);
    }
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
                openContactDetails(contact);
              },
              child: ListTile(
                title: Text(
                    '${contact.firstName} ${contact.lastName ??
                        ''}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.brand),
                    Text(contact.phone),
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
