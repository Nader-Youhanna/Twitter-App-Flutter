import 'package:flutter/material.dart';
import './user_search_item.dart';
import 'search_item.dart';
import '../user_profile/profile.dart';
import './building_suggestions.dart';

CircleAvatar userImages = const CircleAvatar(
  //will be removed once apis are connected
  backgroundImage: AssetImage('assets/images/user_icon.png'),
  radius: 25.0,
);

class MySearchDelegate extends SearchDelegate {
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile("", 1, false);
      }),
    );
  }

  BuildingSuggestions _suggestionsList = BuildingSuggestions();

  MySearchDelegate();
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(
          Icons.arrow_back,
          //Icons.abc,
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
  Widget buildResults(BuildContext context) => Container(
        child: const Text(
          "Search result",
          style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
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
        : FutureBuilder<List<SearchItem>>(
            future: _suggestionsList.getSearchItems(query: query),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  List<SearchItem> data = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 1,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final suggestion = data[index];
                      return GestureDetector(
                        child: suggestion,
                        onTap: suggestion.username != ' '
                            //this means the suggestion item is a user
                            ? () => _goToUserProfile(context)
                            : () => close(
                                //we will not need this function this is temporary
                                context,
                                suggestion
                                    .tweetText), //this means the suggestion item is a tweet
                      );
                    },
                  );
              }
            });
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
