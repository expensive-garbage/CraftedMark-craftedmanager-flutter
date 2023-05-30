// import 'package:flutter/material.dart';
// import 'package:woosignal/models/response/customer.dart';
// import 'package:woosignal/models/response/order.dart';
// import 'package:woosignal/woosignal.dart';
// import 'package:crafted_manager/Models/order_model.dart';
// import 'package:crafted_manager/Models/people_model.dart';
//
// class WooCommerce extends StatefulWidget {
//   const WooCommerce({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _WooCommerce createState() => _WooCommerce();
// }
//
// class _WooCommerce extends State<WooCommerce> {
//   List<People> _customers = [];
//   List<Order> _orders = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCustomersAndOrders();
//   }
//
//   _fetchCustomersAndOrders() async {
//     // Initialize WooSignal
//     await WooSignal.instance.init(appKey: "your app key");
//
//     // Call APIs
//     List<Customer> customers = await WooSignal.instance.getCustomers();
//     List<woosignal.Order> orders = await WooSignal.instance.getOrders();
//
//     setState(() {
//       _customers =
//           customers.map((customer) => People.fromCustomer(customer)).toList();
//       _orders = orders.map((order) => Order.fromWooSignalOrder(order)).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'WooCommerce Customers:',
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _customers.length,
//                 itemBuilder: (context, index) {
//                   People customer = _customers[index];
//                   return ListTile(
//                     title: Text('${customer.firstName} ${customer.lastName}'),
//                     subtitle: Text(customer.email),
//                   );
//                 },
//               ),
//             ),
//             Text(
//               'WooCommerce Orders:',
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _orders.length,
//                 itemBuilder: (context, index) {
//                   Order order = _orders[index];
//                   return ListTile(
//                     title: Text('Order ID: ${order.id}'),
//                     subtitle: Text('Total: ${order.total}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _fetchCustomersAndOrders,
//         tooltip: 'Fetch Customers and Orders',
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
