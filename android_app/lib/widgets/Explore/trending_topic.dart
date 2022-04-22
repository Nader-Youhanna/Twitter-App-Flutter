import 'package:flutter/material.dart';

class TrendingTopic extends StatelessWidget {
  String hashtag = '';
  int trendingNumber = 1;
  int numberOfTweets = 0;
  TrendingTopic(this.hashtag, this.trendingNumber, this.numberOfTweets);

  late String header = trendingNumber.toString() + " . Trending";
  late String retweets = numberOfTweets.toString() + " Tweets";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        header,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 106, 112, 125),
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        hashtag,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
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
      // isThreeLine: true,
    );
  }
}
