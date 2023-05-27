import 'package:flutter/cupertino.dart';

import 'add_new_finance_item.dart';

class FinancialScreen extends StatefulWidget {
  @override
  _FinancialScreenState createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  int segmentedControlValue = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Money Management'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add, color: CupertinoColors.activeBlue),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddNewFinanceItem(
                  itemType: segmentedControlValue,
                ),
              ),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CupertinoSlidingSegmentedControl<int>(
                children: {
                  0: const Text("Bills"),
                  1: const Text("Expenses"),
                  2: const Text("Payments"),
                },
                onValueChanged: (val) {
                  setState(() {
                    segmentedControlValue = val!;
                  });
                },
                groupValue: segmentedControlValue,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (segmentedControlValue == 0) {
                    return CupertinoListTile(title: Text("Bill $index"));
                  } else if (segmentedControlValue == 1) {
                    return CupertinoListTile(title: Text("Expense $index"));
                  } else {
                    return CupertinoListTile(title: Text("Payments $index"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
