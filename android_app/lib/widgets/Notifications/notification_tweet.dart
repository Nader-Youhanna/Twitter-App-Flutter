import 'package:flutter/material.dart';
import '../Tweets/tweet.dart';

///Class that holds the page that displays the tweet with whivh the notification is concerned
class NotificationTweet extends StatelessWidget {
  Tweet tweet;
  NotificationTweet(this.tweet);
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: const Text(
              "Tweet",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                //Icons.abc,
                color: Colors.black,
              ),
              onPressed: () {
                _goBack(context);
              },
            )),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: tweet,
              );
            }));
  }
}
