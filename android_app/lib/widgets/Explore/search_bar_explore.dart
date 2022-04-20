import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [];
  MySearchDelegate(this.searchResults);
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          close(context, null); //cloasing search bar
        },
      );

  @override
  List<Widget>? buildActions(BuildContext context) => query.isEmpty
      ? []
      : [
          IconButton(
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              query = '';
            },
          )
        ];

  @override
  //this is where we display the result of our search
  Widget buildResults(BuildContext context) => Center(
        child: Text(query,
            style: const TextStyle(
              fontSize: 64,
            )),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    // final message = 'Try searching for people, topics or keywords';
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      // if (query == '') {
      //   return false;
      // } else {
      return result.contains(input);
      //}
    }).toList();

    return query.isEmpty
        ? const Center(
            heightFactor: 5,
            child: Text(
              'Try searching for people, topics or keywords',
              style: TextStyle(
                color: Color.fromARGB(255, 90, 90, 90),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1,
            ),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  query = suggestion;
                },
              );
            },
          );
  }

  @override
  String get searchFieldLabel => 'Search Twitter';
  @override
  ThemeData appBarTheme(BuildContext context) {
    // You can use Theme.of(context) directly too
    var superThemeData = super.appBarTheme(context);

    return superThemeData.copyWith(
      appBarTheme: AppBarTheme(elevation: 0.5, color: Colors.grey[50]),
      //hintColor: Color.fromARGB(255, 215, 22, 22),
      primaryColor: Colors.grey[50],
      textTheme: superThemeData.textTheme.copyWith(
        headline6: const TextStyle(
          fontSize: 14.5,
          color: Colors.blue,
        ),
      ),
    );
  }
}
