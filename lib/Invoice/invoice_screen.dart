// import 'package:crafted_manager/Models/invoice_model.dart';
// import 'package:flutter/cupertino.dart';
//
// class InvoiceUI extends StatefulWidget {
//   @override
//   _InvoiceUIState createState() => _InvoiceUIState();
// }
//
// class _InvoiceUIState extends State<InvoiceUI> {
//   List<Invoice> invoices = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch invoices and update the 'invoices' list
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       theme: CupertinoThemeData(
//         brightness: Brightness.dark,
//       ),
//       home: CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: Text('Invoices'),
//           trailing: CupertinoButton(
//             padding: EdgeInsets.all(0),
//             child: Icon(
//               CupertinoIcons.add,
//               color: CupertinoColors.activeBlue,
//             ),
//             onPressed: () {
//               // Navigate to create invoice page
//             },
//           ),
//         ),
//         child: SafeArea(
//           child: ListView.builder(
//             itemCount: invoices.length,
//             itemBuilder: (context, index) {
//               final invoice = invoices[index];
//
//               return GestureDetector(
//                 onTap: () {
//                   // Navigate to manage invoice page
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: CupertinoColors.extraLightBackgroundGray,
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Invoice #${invoice.id}',
//                         style: TextStyle(
//                           color: CupertinoColors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Status: ${invoice.status}',
//                         style: TextStyle(
//                           color: CupertinoColors.systemGrey,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
