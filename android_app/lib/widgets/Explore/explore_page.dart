import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import './search_bar_explore.dart';

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

  List<String> searchResults = [];
  Future<void> httpRequestGet() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/SearchSuggestions');
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
