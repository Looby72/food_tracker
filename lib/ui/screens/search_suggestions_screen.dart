import 'package:flutter/material.dart';

class SearchSuggestionsScreen extends StatefulWidget {
  const SearchSuggestionsScreen({super.key});

  @override
  State<SearchSuggestionsScreen> createState() =>
      _SearchSuggestionsScreenState();
}

class _SearchSuggestionsScreenState extends State<SearchSuggestionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _allSuggestions = ["apple", "banana", "orange", "grapes"];
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = _allSuggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        labelText: 'Welches Produkt hast du gegessen?'),
                    onChanged: (value) {
                      setState(() {
                        _filteredSuggestions = _allSuggestions
                            .where((item) => item
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredSuggestions[index]),
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
