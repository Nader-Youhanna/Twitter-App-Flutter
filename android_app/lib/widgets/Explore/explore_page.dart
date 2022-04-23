import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import './search_bar_explore.dart';
import './user_search_item.dart';
import './search_item.dart';
import './trending_topic.dart';
import '../../functions/http_functions.dart';

CircleAvatar userImages = const CircleAvatar(
  //will be removed once apis are connected
  backgroundImage: AssetImage('assets/images/user_icon.png'),
  radius: 25.0,
);

class ExplorePage extends StatefulWidget {
  //setting up default credentails for each user
  String username = 'Default user';
  String userId = '';
  bool isAdmin = false;
  List<TrendingTopic> trends = <TrendingTopic>[];
  ExplorePage(this.username, this.userId, this.isAdmin);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var _appBarText = 'Search Twitter';
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile("", 1, false);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _getTrendingTopics()); //function is called everytime we open the page
  }

//Function to get the list of trending topics and their number of tweets from backend
  void _getTrendingTopics() async {
    print("Adding trending topiicss");
    httpRequestGet("http://${MY_IP_ADDRESS}:3000/trends", null).then((value) {
      setState(() {
        widget.trends.clear();
        for (var i = 0; i < value.length; i++) {
          widget.trends.add(TrendingTopic.jsonTrend(value[i]));
          widget.trends[i].trendingNumber = i;
        }
      });
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
                    showSearch(context: context, delegate: MySearchDelegate());
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
          //This function renders the list of trending topics
          delegate: SliverChildBuilderDelegate(
            (context, index) => widget.trends[index],
            childCount: widget.trends.length,
          ),
        ),
      ],
    ));
  }
}
