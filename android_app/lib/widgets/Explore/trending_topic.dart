import 'package:flutter/material.dart';

class TrendingTopic extends StatelessWidget {
  String hashtag = '';
  int trendingNumber = 1;
  String numberOfTweets = "0";

  //function to set the list of trending topics that we get once we open explore page
  TrendingTopic.jsonTrend(Map<String, dynamic> jsonTrend) {
    hashtag = jsonTrend['hashtag'] as String;
    numberOfTweets = jsonTrend['retweets'] as String;
  }

  //construnctions the strings that are going to be displayed
  late String header = trendingNumber.toString() + " . Trending";
  late String retweets = numberOfTweets + " Tweets";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        header,
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
            hashtag,
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
            retweets,
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
            )
          ];
        },
      ),
      isThreeLine: true,
    );
  }
}
