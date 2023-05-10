import 'package:crafted_manager/models/people_model.dart';
import 'package:flutter/material.dart';

class SearchPeopleScreen extends StatefulWidget {
  @override
  _SearchPeopleScreenState createState() => _SearchPeopleScreenState();
}

class _SearchPeopleScreenState extends State<SearchPeopleScreen> {
  List<People> _peopleList =
      []; // Dummy list of people, replace with actual data
  List<People> _searchResults = [];

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    } else {
      List<People> results = _peopleList
          .where((person) =>
              person.firstName.toLowerCase().contains(query.toLowerCase()) ||
              person.lastName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search People')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final person = _searchResults[index];
                return ListTile(
                  title: Text('${person.firstName} ${person.lastName}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateOrderScreen(client: person),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
