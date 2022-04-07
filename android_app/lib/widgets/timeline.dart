import 'package:flutter/material.dart';

import '../functions/http_functions.dart';
import '../constants.dart';
import './Tweets/tweet.dart';
import 'package:android_app/widgets/user_profile/profile.dart';

class Timeline extends StatefulWidget {
  List<Tweet> tweets = <Tweet>[];

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final _appBarHeight = 100.0;
  final _bottomNavigationBarHeight = 100.0;

  final _appBarText = 'Search';
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () =>
                {_goToUserProfile(context)}), //button should open to side bar,
        actions: [
          Container(
            width: 260,
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintStyle: const TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 14.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: _appBarText,
              ),
            ),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
      body: Container(
        height: mediaQuery.size.height,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return widget.tweets[index];
          },
          itemCount: widget.tweets.length,
        ),
      ),
    );
  }

  void _getTweets() async {
    print("Adding tweets");
    httpRequestGet("http://" + MY_IP_ADDRESS + "/tweets/", null).then((value) {
      setState(() {
        widget.tweets.clear();
        for (var i = 0; i < value.length; i++) {
          //print("Value " + value[0]['tweetText']);
          widget.tweets.add(Tweet.jsonTweet(value[i]));
          //}
          //print(value);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _getTweets());
  }
}
