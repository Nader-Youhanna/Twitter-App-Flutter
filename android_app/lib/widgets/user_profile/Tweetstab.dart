import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:android_app/functions/tweet_functions.dart';
import 'package:android_app/functions/http_functions.dart';

import '../../constants.dart';

/// This class is used to represent the timeline page.
class TweetTab extends StatefulWidget {
  List<Tweet> tweets = <Tweet>[];

  String _name = "";
  String _username = "";

  TweetTab(this._name, this._username);
  @override
  State<TweetTab> createState() => _TweetTabState();
}

class _TweetTabState extends State<TweetTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<Tweet>> getUserLikes() async {
    print("Adding user tweets");
    Map<String, dynamic> headers = {
      "Authorization": 'Bearer ' + constToken,
      "Content-Type": "application/json"
    };
    Map<String, dynamic> mapTweet = await httpRequestGet(
        "http://${MY_IP_ADDRESS}:3000/${widget._username}", headers);

    //print("=========" + mapTweet['data'][0].toString());
    List<Tweet> tweets = <Tweet>[];
    for (int i = 0; i < mapTweet['tweets'].length; i++) {
      // print("i = " + i.toString());
      // print(mapTweet['data'][i].toString());
      tweets
          .add(Tweet.JsonUserProfileTweet(mapTweet['tweets'][i], false, true));
    }

    return tweets;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        child: RefreshIndicator(
          onRefresh: () => _refresh(),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return widget.tweets[index];
            },
            itemCount: widget.tweets.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //add tweet
        onPressed: () => startAddTweet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Tweet> fetchedtweets = await getUserLikes();
      setState(() {
        widget.tweets = fetchedtweets;
      });
    });
  }

  Future<void> _refresh() async {
    List<Tweet> fetchedtweets = await getUserLikes();
    setState(() {
      widget.tweets = fetchedtweets;
    });
  }
}
