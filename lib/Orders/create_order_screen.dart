import 'package:crafted_manager/Models/people_model.dart';
import 'package:flutter/material.dart';

class CreateOrderScreen extends StatefulWidget {
  final People client;

  const CreateOrderScreen({super.key, required this.client});

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  // Add your form fields and controllers here

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text(
                'Create Order for ${widget.client.firstName} ${widget.client.lastName}')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle form submission and order creation
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
