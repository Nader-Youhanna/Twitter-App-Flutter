import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:flutter/material.dart';
import '../../functions/http_functions.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:android_app/widgets/user_profile/profile.dart';
import './search_bar_explore.dart';

class TrendingTweets extends StatefulWidget {
  @required
  String topic = "";

  TrendingTweets(this.topic);
  late Map<String, dynamic> mapTopic = {"hashtag": topic};
  @override
  State<TrendingTweets> createState() => _TrendingTweetsState();
}

class _TrendingTweetsState extends State<TrendingTweets> {
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile("", 1, false);
      }),
    );
  }

  //sends topic to backend to get list of tweets
  Future<void> _sendTrend(Map<String, dynamic> data) async {
    return await httpRequestPost("http://${MY_IP_ADDRESS}:3000/openTrend/",
        data, <String, String>{"": ""});
  }

//Function to get the list of trending tweets and their types from backend
  Future<List<Tweet>> _getTrendingTweets() async {
    List<Tweet> tweetList = <Tweet>[];
    var data = [];
    print("fetching trending tweets based on topic");
    var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/trendingTweets");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        tweetList = data.map((e) => Tweet.jsonTweet(e, false, true)).toList();
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }

    return tweetList;
  }

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  void initState() {
    super.initState();
    _sendTrend(widget.mapTopic);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _sendTrend(widget.mapTopic));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.grey[50],
                  pinned: true,
                  floating: true,
                  elevation: 0.5,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      //Icons.abc,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _goBack(context);
                    },
                  ), //button should open to side bar,
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
                            hintText: widget.topic,
                          ),
                          onTap: () async {
                            await showSearch(
                              context: context,
                              delegate: MySearchDelegate(),
                              query: widget.topic,
                            );
                          }),
                    ),
                    PopupMenuButton(
                      //button to display the see less list
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.blueGrey,
                      ),
                      elevation: 10,
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<Text>(
                            child: Text(
                              "Search settings", //this is supposed to be static
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const PopupMenuItem<Text>(
                            child: Text(
                              "Save this search", //this is supposed to be static
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const PopupMenuItem<Text>(
                            child: Text(
                              "Share", //this is supposed to be static
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          )
                        ];
                      },
                    ),
                  ],
                ),
              ];
            },
            body: FutureBuilder<List<Tweet>>(
                future: _getTrendingTweets(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      List<Tweet> data = snapshot.data!;
                      return RefreshIndicator(
                        child: ListView.builder(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(0),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return data[index];
                            }),
                        onRefresh: () async {
                          _getTrendingTweets();
                          setState(() {});
                        },
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      );
                  }
                })));
  }
}
