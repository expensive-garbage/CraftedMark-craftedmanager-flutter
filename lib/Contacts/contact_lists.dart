import 'package:crafted_manager/Contacts/people_db_manager.dart';
import 'package:crafted_manager/postgres.dart';
import 'package:flutter/material.dart';

import '../Models/people_model.dart';
import 'contact_detail_widget.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  ContactsListState createState() => ContactsListState();
}

class ContactsListState extends State<ContactsList> {
  List<People>? _contacts;
  List<People>? _filteredContacts;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData('people').then((contacts) {
      setState(() {
        _contacts = contacts.map((e) => People.fromMap(e)).toList();
        _filteredContacts = _contacts;
      });
    });

    _searchController.addListener(() {
      setState(() {
        _filteredContacts = _contacts
            ?.where((contact) =>
                (contact.firstName + ' ' + (contact.lastName ?? ''))
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  Future<void> openContactDetails(People contact) async {
    final updatedContact = await Navigator.push<People>(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailWidget(contact),
      ),
    );
    if (updatedContact != null) {
      refreshContacts();
    }
  }

  Future<void> addNewContact() async {
    final newContact = People.empty();
    final createdContact = await Navigator.push<People>(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailWidget(newContact),
      ),
    );
    if (createdContact is People) {
      refreshContacts();
    }
  }

  Future<void> refreshContacts() async {
    final updatedList = await PeoplePostgres.refreshCustomerList();
    setState(() {
      _contacts = updatedList;
      _filteredContacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              addNewContact();
            },
          ),
        ],
      ),
      body: _contacts == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Search contacts',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _filteredContacts?.length ?? 0,
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts![index];
                      return GestureDetector(
                        onTap: () {
                          openContactDetails(contact);
                        },
                        child: Container(
                          child: ListTile(
                            title: Text(
                              '${contact.firstName} ${contact.lastName ?? ''}',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.brand,
                                ),
                                Text(
                                  contact.phone,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 0.5,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
