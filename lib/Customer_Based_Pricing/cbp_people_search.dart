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
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: const Text('Customer Search',
            style: TextStyle(color: CupertinoColors.white)),
      ),
      child: Column(
        children: [
          CupertinoTextField(
            controller: _searchController,
            onChanged: (_) => _searchCustomers(),
            placeholder: 'Search Customer',
            prefix: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.search,
                color: CupertinoColors.systemGrey,
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: CupertinoColors.systemGrey4),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: CupertinoColors.systemGrey4),
                    ),
                  ),
                  child: CupertinoListTile(
                    title: Text(
                      '${_searchResults[index]['firstname'] ?? ''} ${_searchResults[index]['lastname'] ?? ''} ',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                    subtitle: Text(
                      _searchResults[index]['email'] ?? '',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.right_chevron,
                      color: CupertinoColors.white,
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
