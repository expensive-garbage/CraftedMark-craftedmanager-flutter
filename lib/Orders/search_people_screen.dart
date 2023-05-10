import 'package:crafted_manager/Contacts/people_postgres.dart';
import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Orders/create_order_screen.dart';
import 'package:crafted_manager/Orders/orders_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _SearchPeopleScreenState extends State<SearchPeopleScreen> {
  List<People> _peopleList = [];
  List<People> _searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchPeople(String query) async {
    // Define the details you want to search customers by
    String firstName = query;
    String lastName = query;
    String phone = query;

    // Call the fetchCustomerByDetails function
    People? customer =
        await PeoplePostgres.fetchCustomerByDetails(firstName, lastName, phone);

    if (customer != null) {
      setState(() {
        _peopleList = [customer];
      });
    }
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    } else {
      _fetchPeople(query).then((_) {
        List<People> results = _peopleList
            .where((person) =>
                person.firstName.toLowerCase().contains(query.toLowerCase()) ||
                person.lastName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        setState(() {
          _searchResults = results;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Search People'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CupertinoTextField(
                onChanged: _search,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                placeholder: 'Search',
                clearButtonMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final person = _searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              CreateOrderScreen(client: person),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: CupertinoColors.systemGrey4),
                        ),
                      ),
                      child: Text('${person.firstName} ${person.lastName}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
