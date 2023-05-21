import 'package:crafted_manager/Customer_Based_Pricing/cbp_db_manager.dart'; // new
import 'package:crafted_manager/Customer_Based_Pricing/cbp_people_search.dart';
import 'package:flutter/cupertino.dart';

class CustomerBasedPricingScreen extends StatefulWidget {
  @override
  _CustomerBasedPricingScreenState createState() =>
      _CustomerBasedPricingScreenState();
}

class _CustomerBasedPricingScreenState
    extends State<CustomerBasedPricingScreen> {
  // Variables and methods to handle UI interactions and customer pricing list management

  List<Map<String, dynamic>> _pricingLists = [];

  @override
  void initState() {
    super.initState();
    _loadPricingLists();
  }

  void _loadPricingLists() async {
    // To be updated to use CustomerBasedPricingDbManager
    List<Map<String, dynamic>> pricingLists =
        await CustomerBasedPricingDbManager.instance.getAllPricingLists();
    setState(() {
      _pricingLists = pricingLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: Text('Customer Based Pricing',
            style: CupertinoTheme.of(context)
                .textTheme
                .navTitleTextStyle
                .copyWith(color: CupertinoColors.white)),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CustomerSearchScreen(),
              ),
            );
          },
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.white,
            size: 28.0,
          ),
        ),
      ),
      child: Column(
        children: [
          // Add the necessary widgets to display and interact with customer-based pricing management
          Expanded(
            child: ListView.builder(
              itemCount: _pricingLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: CupertinoColors.systemGrey4),
                    ),
                  ),
                  child: CupertinoListTile(
                    title: Text(
                      _pricingLists[index]['name'],
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                    subtitle: Text(
                      _pricingLists[index]['description'],
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    onTap: () {
                      // Implement navigation and actions to manage pricing list
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
