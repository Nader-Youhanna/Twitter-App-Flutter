import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  //const ExplorePage({});
  var _appBarText = 'Search Twitter';
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile();
      }),
    );
  }

  List<String> searchResults = [
    "Brazil",
    "canada",
    "Russia",
    "Egypt",
    "Lebanon",
    "United States",
    "Argetina",
    "PERU",
    "Sudan",
    "Catalania"
  ];
  Future<void> httpRequestGet() async {
    var url = Uri.parse('http://localhost:3000/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      searchResults = extractedMyInfo['SearchSuggestions'];
    });
    print('EshTa8alllllllllll');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.5,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () =>
                {_goToUserProfile(context)}), //button should open to side bar,
        actions: [
          Container(
            width: 290,
            padding: const EdgeInsets.all(10),
            child: TextField(
                showCursor: false,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: Color.fromARGB(255, 229, 233, 235),
                  hintStyle: const TextStyle(
                    fontSize: 14.5,
                    color: Color.fromARGB(255, 100, 99, 99),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: _appBarText,
                ),
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: MySearchDelegate(searchResults));
                }),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
      body: const Center(
          child: Text('Explore Page',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold))),
    );
  }
}

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
        : ListView.builder(
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
