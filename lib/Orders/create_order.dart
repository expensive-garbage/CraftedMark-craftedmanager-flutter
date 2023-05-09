import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted_manager/postgres.dart';
import 'package:postgres/postgres.dart';

// Establishes a connection to the PostgreSQL database
Future<PostgreSQLConnection> connectToPostgres() async {
  final connection = PostgreSQLConnection(
    'localhost', // Database host
    5432, // Port number
    'craftedmanager_db', // Database name
    username: 'craftedmanager_dbuser', // Database username
    password: '!!Laganga1983', // Database password
  );

  await connection.open();
  print('Connected to PostgreSQL');
  return connection;
}

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<Map<String, dynamic>> peopleData = [];

  Future<void> fetchPeopleData() async {
    final data = await fetchData('people');
    setState(() {
      peopleData = data;
    });
  }

  Future<List<Map<String, dynamic>>> searchData(String tableName, String searchQuery, Map<String, dynamic> substitutionValues) async {
    final connection = await connectToPostgres();
    final result = await connection.query('SELECT * FROM $tableName WHERE $searchQuery', substitutionValues: substitutionValues);
    await connection.close();
    // ignore: avoid_print
    print('Closed connection to PostgreSQL');

    if (kDebugMode) {
      print('Searched $tableName data with query: $searchQuery and substitution values: $substitutionValues. Result: $result');
    }

    return result.map((row) => row.toColumnMap()).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchPeopleData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Create Order'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Select a person:'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: peopleData.length,
                itemBuilder: (context, index) {
                  final person = peopleData[index];
                  return CupertinoButton(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person['firstname'] + person['lastname'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(person['email']),
                      ],
                    ),
                    onPressed: () {
                      // // Inserts data into the specified table
                      // Future<void> insertData(String tableName, Map<String, dynamic> data) async {
                      //   final connection = await connectToPostgres();
                      //   final columns = data.keys.join(', ');
                      //   final values = data.keys.map((key) => '@$key').join(', ');
                      //
                      //   await connection.execute(
                      //     'INSERT INTO $tableName ($columns) VALUES ($values)',
                      //     substitutionValues: data,
                      //   );
                      //   await connection.close();
                      //   print('Closed connection to PostgreSQL');
                      //
                      //   if (kDebugMode) {
                      //     print('Inserted data into $tableName: $data');
                      //   }
                      // }
                      //
                      // // Inserts data into the orders table
                      // Future<void> insertOrderData(Map<String, dynamic> data) async {
                      //   await insertData('orders', data);
                      // }
                    },
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


// import 'package:flutter/cupertino.dart';
//
// class CreateOrder extends StatefulWidget {
//   @override
//   _CreateOrderState createState() => _CreateOrderState();
// }
//
// class _CreateOrderState extends State<CreateOrder> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _shippingAddressController = TextEditingController();
//   final TextEditingController _totalAmountController = TextEditingController();
//
//   List<Map<String, TextEditingController>> _orderItems = [];
//
//   void _addOrderItem() {
//     setState(() {
//       _orderItems.add({
//         'quantity': TextEditingController(),
//         'price': TextEditingController(),
//         'discount': TextEditingController(),
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _shippingAddressController.dispose();
//     _totalAmountController.dispose();
//     for (var item in _orderItems) {
//       item['quantity']!.dispose();
//       item['price']!.dispose();
//       item['discount']!.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: const Text('Create Order'),
//         previousPageTitle: 'Orders',
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               CupertinoTextField(
//                 controller: _firstNameController,
//                 placeholder: 'First Name',
//               ),
//               const SizedBox(height: 8),
//               CupertinoTextField(
//                 controller: _lastNameController,
//                 placeholder: 'Last Name',
//               ),
//               const SizedBox(height: 8),
//               CupertinoTextField(
//                 controller: _shippingAddressController,
//                 placeholder: 'Shipping Address',
//               ),
//               const SizedBox(height: 8),
//               CupertinoTextField(
//                 controller: _totalAmountController,
//                 placeholder: 'Total Amount',
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 16),
//               const Text('Order Items:'),
//               const SizedBox(height: 8),
//               for (var item in _orderItems)
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CupertinoTextField(
//                         controller: item['quantity']!,
//                         placeholder: 'Quantity',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: CupertinoTextField(
//                         controller: item['price']!,
//                         placeholder: 'Price',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: CupertinoTextField(
//                         controller: item['discount']!,
//                         placeholder: 'Discount',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: 8),
//               CupertinoButton(
//                 onPressed: _addOrderItem,
//                 child: const Text('Add Item'),
//               ),
//               const SizedBox(height: 16),
//               CupertinoButton(
//                 color: CupertinoColors.activeBlue,
//                 onPressed: () {
//                   // Add logic to create a new order and save it to the database
//                 },
//                 child: const Text('Create Order'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // Add these functions to your database handling code
// Future<int> insertOrder(Order order);
// Future<void> insertOrderItem(OrderItem orderItem);
//
//
//
//
// CupertinoButton(
// color: CupertinoColors.activeBlue,
// onPressed: () async {
// // Create an Order object
// Order newOrder = Order(
// peopleId: /* Provide people_id */,
// orderDate: DateTime.now(),
// shippingAddress: _shippingAddressController.text,
// billingAddress: /* Provide billing address */,
// totalAmount: double.parse(_totalAmountController.text),
// orderStatus: /* Provide order status */,
// );
//
// // Insert the order into the database
// int orderId = await insertOrder(newOrder);
//
// // Iterate through order items and insert them into the database
// for (var item in _orderItems) {
// OrderItem orderItem = OrderItem(
// orderId: orderId,
// productId: /* Provide product_id */,
// quantity: int.parse(item['quantity']!.text),
// price: double.parse(item['price']!.text),
// discount: double.parse(item['discount']!.text),
// description: item['description']!.text,
// );
//
// await insertOrderItem(orderItem);
// }
//
// // Show a success message and navigate back to the previous screen
// showCupertinoDialog(
// context: context,
// builder: (BuildContext context) => CupertinoAlertDialog(
// title: const Text('Order Created'),
// content: const Text('The order has been created successfully.'),
// actions: [
// CupertinoDialogAction(
// child: const Text('OK'),
// onPressed: () {
// Navigator.of(context).pop(); // Close the dialog
// Navigator.of(context).pop(); // Navigate back to the previous screen
// },
// ),
// ],
// ),
// );
// },
// child: const Text('Create Order'),
// ),
//
//
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.only(bottom: 8.0),
// child: Text('Search People:', style: TextStyle(fontSize: 18)),
// ),
// Row(
// children: [
// Expanded(
// child: CupertinoTextField(
// controller: _searchController,
// placeholder: 'Enter name or email',
// clearButtonMode: OverlayVisibilityMode.editing,
// ),
// ),
// CupertinoButton(
// onPressed: _searchPeople,
// child: Icon(CupertinoIcons.search),
// ),
// ],
// ),
// Container(
// height: 100, // Adjust the height as needed
// child: ListView.builder(
// itemCount: _searchResults.length,
// itemBuilder: (BuildContext context, int index) {
// final person = _searchResults[index];
// return GestureDetector(
// onTap: () {
// // Handle the person selection logic here
// },
// child: Text('${person['firstname']} ${person['lastname']} (${person['email']})'),
// );
// },
// ),
// ),
// // Rest of the CreateOrder form fields and button
// ],
// ),
