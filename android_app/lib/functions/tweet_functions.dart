import 'package:flutter/material.dart';

import './http_functions.dart';
import '../widgets/Tweets/tweet.dart';

Future<void> addTweet(
    Map<String, dynamic> data, String ipAddress, String port) async {
  return await httpRequestPost(
      "http://" + ipAddress + ":" + port + "/tweets/", data);
}

Future<List<Tweet>> getTweets(String ipAddress, String port) async {
  print("Adding tweets");
  var mapTweet = await httpRequestGet(
      "http://" + ipAddress + ":" + port + "/tweets/", null);

  List<Tweet> tweets = <Tweet>[];
  for (int i = 0; i < mapTweet.length; i++) {
    tweets.add(Tweet.jsonTweet(mapTweet[i], false));
  }

  return tweets;
}

void startAddTweet(BuildContext ctx, String ipAddress, String port) async {
  String tweetText = "";
  var tweetTextController = TextEditingController();
  showModalBottomSheet(
    context: ctx,
    builder: (bCtx) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Cancel'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  tweetText = tweetTextController.text;
                  print(tweetText);
                  var data = <String, dynamic>{
                    'userId': 1,
                    'createdAt': '2020-01-01T00:00:00.000Z',
                    'tweetText': tweetText,
                    'images': [],
                    'favouriters': [],
                    'retweeters': [],
                    'replies': [],
                  };
                  await addTweet(data, ipAddress, port);
                  print("Tweet added");
                  await getTweets(ipAddress, port);
                  print("Tweets retrieved");
                  Navigator.pop(ctx);
                },
                child: Text('Tweet'),
              ),
            ],
          ),
          //add tweet
          Container(
            padding: const EdgeInsets.all(10),
            //take input text from user
            child: TextField(
              decoration: const InputDecoration.collapsed(
                hintStyle: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 14.5,
                ),
                hintText: 'What\'s happening?',
              ),
              controller: tweetTextController,
            ),
          )
        ],
      );
    },
    isScrollControlled: true,
    enableDrag: false,
    useRootNavigator: true,
  );
}
