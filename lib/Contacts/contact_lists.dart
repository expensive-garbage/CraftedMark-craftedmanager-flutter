import 'package:crafted_manager/Contacts/people_db_manager.dart';
import 'package:crafted_manager/postgres.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Models/people_model.dart';
import 'contact_detail_widget.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  ContactsListState createState() => ContactsListState();
}

class ContactsListState extends State<ContactsList> {
  List<People>? _contacts;
  final RefreshController _refreshController = RefreshController();

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
    final updatedContact = await Navigator.push<People>(
      context,
      CupertinoPageRoute(
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
      CupertinoPageRoute(
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
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.black,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.black,
          middle: const Text('Contacts'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.add),
            onPressed: () {
              addNewContact();
            },
          ),
        ),
        child: Material(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: _contacts == null
              ? const Center(child: CupertinoActivityIndicator())
              : SmartRefresher(
                  controller: _refreshController,
                  onRefresh: refreshContacts,
                  child: ListView.separated(
                    itemCount: _contacts!.length,
                    itemBuilder: (context, index) {
                      final contact = _contacts![index];
                      return GestureDetector(
                        onTap: () {
                          openContactDetails(contact);
                        },
                        child: Container(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: ListTile(
                            title: Text(
                              '${contact.firstName} ${contact.lastName ?? ''}',
                              style: TextStyle(
                                color: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .color,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.brand,
                                  style: TextStyle(
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color
                                        ?.withAlpha(150),
                                  ),
                                ),
                                Text(
                                  contact.phone,
                                  style: TextStyle(
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color
                                        ?.withAlpha(150),
                                  ),
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
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
