import 'package:crafted_manager/Customer_Based_Pricing/cbp_db_manager.dart';
import 'package:flutter/cupertino.dart';

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
            'firstName ILIKE @searchText OR email ILIKE @searchText',
            {'searchText': '%${_searchController.text}%'});
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return CupertinoPageScaffold(
      backgroundColor:
          darkModeOn ? CupertinoColors.black : CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            darkModeOn ? CupertinoColors.black : CupertinoColors.white,
        middle: const Text(
          'Customer Search',
          style: TextStyle(color: CupertinoColors.activeGreen),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: CupertinoTextField(
              controller: _searchController,
              onChanged: (_) => _searchCustomers(),
              placeholder: 'Search Customer',
              style: TextStyle(
                  color: darkModeOn
                      ? CupertinoColors.white
                      : CupertinoColors.black),
              placeholderStyle: darkModeOn
                  ? const TextStyle(color: CupertinoColors.systemGrey)
                  : const TextStyle(color: CupertinoColors.systemGrey3),
              prefix: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.activeOrange,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: darkModeOn
                    ? CupertinoColors.black
                    : CupertinoColors.systemGrey6,
              ),
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
                      '${_searchResults[index]['firstname'] ?? ''} ${_searchResults[index]['lastname'] ?? ''} ',
                      style: TextStyle(
                          color: darkModeOn
                              ? CupertinoColors.white
                              : CupertinoColors.black),
                    ),
                    subtitle: Text(
                      _searchResults[index]['email'] ?? '',
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
                      // Push pricing list creation screen with selected customerId.
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
