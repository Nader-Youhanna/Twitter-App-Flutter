import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import '../../functions/tweet_functions.dart';
import '../side_bar.dart';
import './search_bar_explore.dart';
import './user_search_item.dart';
import './search_item.dart';
import './trending_topic.dart';
import '../../functions/http_functions.dart';
import 'package:flutter/foundation.dart';

CircleAvatar userImages = const CircleAvatar(
  //will be removed once apis are connected
  backgroundImage: AssetImage('assets/images/user_icon.png'),
  radius: 25.0,
);

class ExplorePage extends StatefulWidget {
  ///setting up default credentails for each user (username , token , and if the user is an admin)
  String username = 'Default user';
  String token = '';
  bool isAdmin = false;
  List<TrendingTopic> trends = <TrendingTopic>[];
  ExplorePage(this.username, this.token, this.isAdmin);

  @override
  State<ExplorePage> createState() => ExplorePageState();
}

///class to create the explore page with the search bar and the list of trends
class ExplorePageState extends State<ExplorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _appBarText = 'Search Twitter';
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile("", false);
      }),
    );
  }

  bool isAndroid = true;
  @override
  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) =>
    //     _getTrendingTopics()); //function is called everytime we open the page
  }

  ///Function to fetch the list of trending topics and their number of tweets from backend
  Future<List<TrendingTopic>> getTrendingTopics() async {
    List<TrendingTopic> topicList = <TrendingTopic>[];
    var data = [];
    print("fetching trending topics");
    var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/trends");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        topicList = data.map((e) => TrendingTopic.jsonTrend(e)).toList();
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }

    return topicList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    print("height: $height \n");
    print("width is $width");
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(name: 'nido', username: 'nido123'),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey[50],
                pinned: true,
                floating: true,
                elevation: 0.5,
                leading: IconButton(
                    icon: const Icon(Icons
                        .person_rounded), //should be changed to google profile icon
                    color: Colors.black,
                    onPressed: () {
                      // _goToUserProfile(context)
                      _scaffoldKey.currentState!.openDrawer();
                    }), //button should open to side bar,
                actions: [
                  Container(
                    width: isAndroid
                        ? width * (290 / 392.7)
                        : width * (1190 / 1280),
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
                        // onTap: () {
                        //   //redirects us to the page with the searching elements
                        //   showSearch(
                        //       context: context,
                        //       delegate: MySearchDelegate(' '));
                        // }
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: MySearchDelegate(),
                          );
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
            ];
          },
          body: FutureBuilder<List<TrendingTopic>>(
              future: getTrendingTopics(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    List<TrendingTopic> data = snapshot.data!;
                    for (int i = 0; i < data.length; i++) {
                      data[i].trendingNumber = i + 1;
                    }
                    return data.isNotEmpty
                        ? RefreshIndicator(
                            child: ListView.builder(
                                clipBehavior: Clip.hardEdge,
                                padding: const EdgeInsets.all(0),
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return data[index];
                                }),
                            onRefresh: () async {
                              getTrendingTopics();
                              setState(() {});
                            },
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                          )
                        : Container(
                            child: Column(
                              children: [
                                const SizedBox(height: 220),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Nothing to see here\n',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 34.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '__ yet.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 34.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //padding: const EdgeInsets.all(30),
                            margin: const EdgeInsets.all(30),
                          );
                }
              })),
      floatingActionButton: FloatingActionButton(
        // button should open the what's happening page
        onPressed: () => startAddTweet(context, MY_IP_ADDRESS, "3000"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
