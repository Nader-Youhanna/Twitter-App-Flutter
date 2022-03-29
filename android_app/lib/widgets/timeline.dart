import 'package:flutter/material.dart';

import './Tweets/tweet.dart';

class Timeline extends StatefulWidget {
  final List<Tweet> tweets;

  Timeline(this.tweets);

  @override
  State<Timeline> createState() => _TimelineState(tweets);
}

class _TimelineState extends State<Timeline> {
  final List<Tweet> tweets;

  final appBarHeight = 100.0;
  final bottomNavigationBarHeight = 100.0;
  _TimelineState(this.tweets);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height - appBarHeight - bottomNavigationBarHeight,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return tweets[index];
        },
        itemCount: tweets.length,
      ),
    );
  }
}
