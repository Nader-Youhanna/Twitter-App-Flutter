import 'package:android_app/constants.dart';
import 'package:flutter/material.dart';

import './http_functions.dart';
import '../widgets/Tweets/tweet.dart';

///This function sends the tweet to the [ipAddress] and port [port] of the backend and return the response.
Future<Map<String, dynamic>> addTweet(Map<String, dynamic> data) async {
  Map<String, dynamic> headers = {
    "Authorization": token,
    "Content-Type": "application/json"
  };
  return await httpRequestPost(
    URL.postTweet,
    data,
    headers,
  );
}

/// This function get the tweets from the [ipAddress] and port [port] of the backend and return the response.
Future<List<Tweet>> getTweets() async {
  print("Adding tweets");
  Map<String, dynamic> headers = {
    "Authorization": token,
    "Content-Type": "application/json"
  };
  Map<String, dynamic> mapTweet = await httpRequestGet(URL.getTweets, headers);

  //print("=========" + mapTweet['data'][0].toString());
  List<Tweet> tweets = <Tweet>[];
  for (int i = 0; i < mapTweet['data'].length; i++) {
    // print("i = " + i.toString());
    // print(mapTweet['data'][i].toString());
    tweets.add(Tweet.jsonTweet(mapTweet['data'][i], false, true));
  }

  return tweets;
}

/// This function opens the modal sheet to add a new tweet and send it to the [ipAddress] and port [port].
void startAddTweet(BuildContext ctx) async {
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
                  //check for tagged users
                  List<String?> taggedUsers = [];
                  RegExp exp = RegExp(r'@[a-zA-Z0-9]+');
                  Iterable<RegExpMatch> matches = exp.allMatches(tweetText);
                  for (var match in matches) {
                    taggedUsers.add(match.group(0));
                  }
                  //print(taggedUsers);
                  print(tweetText);
                  return;
                  var data = <String, dynamic>{
                    "userId": "6261594af12e411a8115627f",
                    "body": tweetText,
                    "media": ["url1", "url2"],
                    "taggedUsers": ["624c40e1e42ed8fe5b098d2b"]
                  };
                  await addTweet(data);
                  print("Tweet added");
                  await getTweets();
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

//get replies
Future<List<Tweet>> getReplies(String tweetId, String userName) async {
  Map<String, dynamic> headers = {
    "Authorization": token,
    "Content-Type": "application/json"
  };
  Map<String, dynamic> mapTweet = await httpRequestGet(
      URL.getReplies.replaceAll(':tweetId', tweetId), headers);

  //print("=========" + mapTweet['data'][0].toString());
  List<Tweet> tweets = <Tweet>[];
  for (int i = 0; i < mapTweet['users'].length; i++) {
    // print("i = " + i.toString());
    // print(mapTweet['data'][i].toString());

    Tweet tweet = Tweet.jsonReply(mapTweet['users'][i], false, true);
    tweet.setReplyTo(userName);
    tweets.add(tweet);
  }

  return tweets;
}
