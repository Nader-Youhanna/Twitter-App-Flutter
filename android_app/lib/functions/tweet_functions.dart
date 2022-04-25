import 'package:android_app/constants.dart';
import 'package:flutter/material.dart';

import './http_functions.dart';
import '../widgets/Tweets/tweet.dart';

Future<void> addTweet(
    Map<String, dynamic> data, String ipAddress, String port) async {
  Map<String, dynamic> headers = {
    "authorization": token,
    "Content-Type": "application/json"
  };
  return await httpRequestPost(
    "http://" + ipAddress + ":" + port + "/tweets/",
    data,
    headers,
  );
}

Future<List<Tweet>> getTweets(String ipAddress, String port) async {
  print("Adding tweets");
  Map<String, dynamic> headers = {
    "authorization": token,
    "Content-Type": "application/json"
  };
  Map<String, dynamic> mapTweet = await httpRequestGet(
      "http://" + ipAddress + ":" + port + "/home/", headers);

  //print("=========" + mapTweet['data'][0].toString());
  List<Tweet> tweets = <Tweet>[];
  for (int i = 0; i < mapTweet.length; i++) {
    tweets.add(Tweet.jsonTweet(mapTweet['data'][i], false, true));
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
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
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
