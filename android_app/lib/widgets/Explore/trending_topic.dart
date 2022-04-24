import 'package:flutter/material.dart';
import '../../functions/http_functions.dart';
import '../../constants.dart';
import './trending_tweets.dart';

class TrendingTopic extends StatefulWidget {
  String hashtag = '';
  int trendingNumber = 1;
  String numberOfTweets = "0";

  //function to set the list of trending topics that we get once we open explore page
  TrendingTopic.jsonTrend(Map<String, dynamic> jsonTrend) {
    hashtag = jsonTrend['hashtag'] as String;
    numberOfTweets = jsonTrend['retweets'] as String;
  }
  @override
  State<TrendingTopic> createState() => _TrendingTopicState();

  //construnctions the strings that are going to be displayed
  late String header = trendingNumber.toString() + " . Trending";
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

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   widget.trendingNumber++;
    // });
  }

  @override
  Widget build(BuildContext context) {
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
      trailing: PopupMenuButton(
        //button to display the see less list

        elevation: 10,
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<Text>(
              child: Text(
                "Not interested in this", //this is supposed to be static
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            const PopupMenuItem<Text>(
              child: Text(
                "This trend is harmful or spammy", //this is supposed to be static
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            )
          ];
        },
      ),
      isThreeLine: true,
    );
  }
}
