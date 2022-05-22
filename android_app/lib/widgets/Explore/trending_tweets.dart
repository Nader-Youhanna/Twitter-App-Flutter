import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../functions/http_functions.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:android_app/widgets/user_profile/profile.dart';
import './search_bar_explore.dart';

///class to create the page with the tweets concerning a specific topic
class TrendingTweets extends StatefulWidget {
  @required

  ///the trending topic is the only data memeber in the class
  String topic = "";

  ///class takes the concerned topic in its constructor
  TrendingTweets(this.topic);
  //late Map<String, dynamic> mapTopic = {"hashtag": topic};
  @override
  State<TrendingTweets> createState() => TrendingTweetsState();
}

///class to create the states of teh page
class TrendingTweetsState extends State<TrendingTweets> {
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile("", false);
      }),
    );
  }

  // ///sends topic to backend to get list of tweets
  // Future<Map<String, dynamic>> sendTrend(Map<String, dynamic> data) async {
  //   return await httpRequestPost(
  //     "http://${MY_IP_ADDRESS}:3000/openTrend/",
  //     data,
  //     <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer ' + token
  //     },
  //   );
  // }

  ///Function to get the list of trending tweets and their types from backend
  Future<List<Tweet>> getTrendingTweets() async {
    List<Tweet> tweetList = <Tweet>[];
    String hashtag = widget.topic;
    var data = [];
    print("fetching trending tweets based on topic");
    var url = Uri.parse("http://$MY_IP_ADDRESS:3000/explore/$hashtag");
    Map<String, dynamic> headers = {
      "Authorization": 'Bearer ' + constToken,
      "Content-Type": "application/json"
    };
    var request = http.Request('GET', url);
    if (headers != null) {
      request.headers['Content-Type'] = headers['Content-Type'];
      request.headers['Authorization'] = headers['Authorization'];
    }
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    var mapData = json.decode(response.body);
    for (int i = 0; i < mapData['tweets'].length; i++) {
      tweetList.add(Tweet.jsonTweet(mapData['tweets'][i], false, true));
    }

    return tweetList;
  }

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override

  ///at every callback to the page we send a new request for the list of tweets

  bool isAndroid = true;
  @override
  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => sendTrend(widget.mapTopic));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
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
                    SizedBox(width: 40),
                  ],
                ),
              ];
            },
            body: FutureBuilder<List<Tweet>>(
                future: getTrendingTweets(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.data == null) {
                        return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: 100),
                              Center(child: CircularProgressIndicator()),
                              SizedBox(height: 50),
                              Center(
                                child: Text('Server error..please wait'),
                              )
                            ]);
                      } else {
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
                            getTrendingTweets();
                            setState(() {});
                          },
                          triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        );
                      }
                  }
                })));
  }
}
