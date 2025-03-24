import 'package:flutter/material.dart';
import 'package:green_fairm/data/model/field.dart';

import 'package:green_fairm/presentation/widget/field_search_item.dart';

class AppSearchBar extends StatefulWidget {
  final List<Field> fields;
  const AppSearchBar({super.key, required this.fields});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(
            context: context, delegate: CustomSearchDelegate(widget.fields));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300), // Outer border
            borderRadius: BorderRadius.circular(10), // Border radius
          ),
          child: const TextField(
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search, // Leading search icon
                color: Colors.white,
              ),
              // suffixIcon: Icon(
              //   Icons.mic, // Trailing micro icon
              //   color: Colors.white,
              // ),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none, // Remove internal borders
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchField = ['Field 1', 'Field 2', 'Field 3'];
  final List<Field> fields;
  CustomSearchDelegate(this.fields);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Field> searchResult = fields
        .where((field) =>
            (field.name?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResult[index].name ?? ''),
          onTap: () {
            close(context, searchResult[index].name);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Field> searchResult = fields
        .where((field) =>
            (field.name?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return FieldSearchItem(field: searchResult[index]);
      },
    );
  }
}
