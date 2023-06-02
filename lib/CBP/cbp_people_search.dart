import 'package:crafted_manager/CBP/cbp_db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cbp_list_product_screen.dart';

class CustomerSearchScreen extends StatefulWidget {
  @override
  _CustomerSearchScreenState createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _searchCustomers() async {
    List<Map<String, dynamic>> results =
        await CustomerBasedPricingDbManager.instance.search(
            'people',
            'firstname ILIKE @searchText OR email ILIKE @searchText',
            {'searchText': '%${_searchController.text}%'});
    print(
        'Search Results: $results'); // Add this line to print the search results
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: darkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: darkModeOn ? Colors.black : Colors.white,
        title: const Text(
          'Customer Search',
          style: TextStyle(color: Colors.green),
        ),
        iconTheme: IconThemeData(
          color: darkModeOn ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _searchCustomers(),
              decoration: InputDecoration(
                hintText: 'Search Customer',
                hintStyle: TextStyle(
                  color: darkModeOn
                      ? CupertinoColors.systemGrey
                      : CupertinoColors.systemGrey3,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.orange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor:
                    darkModeOn ? Colors.black : CupertinoColors.systemGrey6,
              ),
              style: TextStyle(
                  color: darkModeOn
                      ? CupertinoColors.white
                      : CupertinoColors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: darkModeOn
                        ? const Border(
                            bottom:
                                BorderSide(color: CupertinoColors.systemGrey2))
                        : const Border(
                            bottom:
                                BorderSide(color: CupertinoColors.systemGrey4)),
                  ),
                  child: CupertinoListTile(
                    title: Text(
                      '${_searchResults[index]['people']['firstname'] ?? ''} ${_searchResults[index]['people']['lastname'] ?? ''} ',
                      style: TextStyle(
                          color: darkModeOn
                              ? CupertinoColors.white
                              : CupertinoColors.black),
                    ),
                    subtitle: Text(
                      _searchResults[index]['people']['email'] ?? '',
                      style: TextStyle(
                          color: darkModeOn
                              ? CupertinoColors.systemGrey
                              : CupertinoColors.systemGrey3),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.right_chevron,
                      color: CupertinoColors.activeOrange,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerPricingListScreen(
                            customerId: _searchResults[index]['people']['id'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
