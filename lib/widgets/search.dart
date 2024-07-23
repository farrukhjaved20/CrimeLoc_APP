import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SearchTextFieldPage()),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text('Tap to search...'),
              ),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTextFieldPage extends StatefulWidget {
  const SearchTextFieldPage({super.key});

  @override
  _SearchTextFieldPageState createState() => _SearchTextFieldPageState();
}

class _SearchTextFieldPageState extends State<SearchTextFieldPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
