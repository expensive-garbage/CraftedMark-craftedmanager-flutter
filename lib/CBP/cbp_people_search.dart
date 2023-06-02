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

  Future<Map<String, String>?> _showAddPricingListDialog(
      BuildContext context) async {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    return showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Pricing List Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                String name = _nameController.text.trim();
                String description = _descriptionController.text.trim();
                if (name.isNotEmpty) {
                  Navigator.of(context)
                      .pop({'name': name, 'description': description});
                }
              },
            ),
          ],
        );
      },
    );
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
                    onTap: () async {
                      int customerId = _searchResults[index]['people']['id'];
                      print('Selected customer: $customerId');
                      await CustomerBasedPricingDbManager.instance
                          .updateCustomerBasedPricing(customerId, true);

                      int? existingPricingListId = _searchResults[index]
                          ['people']['assigned_pricing_list_id'];

                      if (existingPricingListId != null) {
                        print(
                            "Existing pricing list found with id: $existingPricingListId");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerPricingListScreen(
                              customerId: customerId,
                            ),
                          ),
                        );
                      } else {
                        Map<String, String>? pricingListData =
                            await _showAddPricingListDialog(context);
                        if (pricingListData != null) {
                          int? pricingListId =
                              await CustomerBasedPricingDbManager.instance
                                  .addPricingList(
                            customerId: customerId,
                            name: pricingListData['name']!,
                            description: pricingListData['description']!,
                          );

                          if (pricingListId != null) {
                            // Update the assigned_pricing_list_id after creating the pricing list
                            await CustomerBasedPricingDbManager.instance
                                .updateCustomerPricingListId(
                                    customerId, pricingListId);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerPricingListScreen(
                                  customerId: customerId,
                                ),
                              ),
                            );
                          } else {
                            print(
                                'Failed to create a new pricing list for customer: $customerId');
                          }
                        }
                      }
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
