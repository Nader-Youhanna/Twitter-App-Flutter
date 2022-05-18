// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../functions/http_functions.dart';
import '../../constants.dart';
import './trending_tweets.dart';

/// class to create the elements that appear in the trending page (its data (hashtag, number of tweets) is fetched from the server)
class TrendingTopic extends StatefulWidget {
  String hashtag = '';

  ///the trending topic
  int trendingNumber = 1;

  ///the number displayed with the topic
  String numberOfTweets = "0";

  ///the number of tweets for each topic

  ///named constructor to map the data fetched from server
  TrendingTopic.jsonTrend(Map<String, dynamic> jsonTrend) {
    hashtag = jsonTrend['hashtag'] as String;
    numberOfTweets = jsonTrend['retweets'] as String;
  }
  @override
  State<TrendingTopic> createState() => _TrendingTopicState();

  ///construnctions the header string that is going to be displayed befor the topic
  late String header = trendingNumber.toString() + " . Trending";

  ///construnctions the string that contains the number of tweets
  late String retweets = numberOfTweets + " Tweets";
}

class _TrendingTopicState extends State<TrendingTopic> {
  void _goToTweetList(BuildContext ctx, String data) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return TrendingTweets(data);
      }),
    );
  }

  bool isAndroid = true;
  @override
  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
    super.initState();
    // setState(() {
    //   widget.trendingNumber++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return ListTile(
      onTap: () {
        _goToTweetList(context, widget.hashtag);
      },
      title: Text(
        widget.header,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 106, 112, 125),
          fontSize: 15,
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.hashtag,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.retweets,
            style: const TextStyle(
              color: Color.fromARGB(255, 106, 112, 125),
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: IconButton(
          color: Color.fromARGB(255, 194, 211, 219),
          icon: Icon(Icons.more_vert),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                context: context,
                builder: (builder) {
                  return Container(
                      width: width,
                      alignment: Alignment.bottomLeft,
                      height: isAndroid ? height * (120 / 825.5) : 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  minimumSize: MaterialStateProperty.all(
                                      Size.fromHeight(40)),
                                  alignment: Alignment.bottomLeft,
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: Text(
                                "Not interested in this",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 82, 82, 82),
                                    fontStyle: FontStyle.normal),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }, //should be a function to delete trend from list--> send to backend
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  minimumSize: MaterialStateProperty.all(
                                      Size.fromHeight(40)),
                                  alignment: Alignment.centerLeft,
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: Text(
                                "This trend is harmful or spammy",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 82, 82, 82),
                                    fontStyle: FontStyle.normal),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }, //should be a function to delete trend from list--> send to back end to delete it
                            ),
                          ]));
                });
          }),
      isThreeLine: true,
    );
  }
}
