import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import './search_bar_explore.dart';
import './user_search_item.dart';

CircleAvatar userImages = const CircleAvatar(
  backgroundImage: AssetImage('assets/images/user_icon.png'),
  radius: 25.0,
);

class ExplorePage extends StatefulWidget {
  //setting up default credentails for each user
  String username = 'Default user';
  int userId = 0;
  bool isAdmin = false;
  ExplorePage(this.username, this.userId, this.isAdmin);

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

  List<UserSearch> searchResults = List<UserSearch>.generate(
    10,
    (i) => i % 6 == 0
        ? UserSearch('habibaAssem16', '@habibaAssem', userImages)
        : UserSearch('NoraMattar56', '@NoraaM', userImages),
  );

  Future<void> httpRequestGet() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/SearchSuggestions');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      searchResults = extractedMyInfo['SearchSuggestions'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.grey[50],
          pinned: true,
          floating: true,
          elevation: 0.5,
          leading: IconButton(
              icon: const Icon(Icons
                  .person_rounded), //should be changed to google profile icon
              color: Colors.black,
              onPressed: () => {
                    _goToUserProfile(context)
                  }), //button should open to side bar,
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
                    //redirects us to the page with the searching elements
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
          bottom: AppBar(
            title: const Text('Trends',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
            backgroundColor: Colors.grey[50],
            elevation: 0.0,
            leading: null,
            automaticallyImplyLeading: false,
          ),
        ),
        SliverList(
          //should be the list of trending topics
          delegate: SliverChildBuilderDelegate(
            // The builder function returns a ListTile with a title that
            // this is temporary
            (context, index) => searchResults[index],
            childCount: 10,
          ),
        ),
        // UserSearch('habiba', '@habibaAssem', userImage),
      ],
    ));
  }
}
