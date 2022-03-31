import 'package:flutter/material.dart';

import './Tweets/tweet.dart';

class Timeline extends StatefulWidget {
  final List<Tweet> tweets;

  Timeline(this.tweets);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final appBarHeight = 100.0;
  final bottomNavigationBarHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return widget.tweets[index];
        },
        itemCount: widget.tweets.length,
      ),
    );
  }
}
