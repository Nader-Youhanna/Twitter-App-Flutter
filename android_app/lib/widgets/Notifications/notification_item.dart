import 'package:flutter/material.dart';
import '../Tweets/tweet.dart';
import './notification_tweet.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem();

  String username = "username";
  String notificationType = " ";
  late Tweet tweet;
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 13.0,
  );

//function to set the list of notifications that we get when we open notifications list
  NotificationItem.jsonNotification(Map<String, dynamic> jsonNotification) {
    username = jsonNotification['username'] as String;
    notificationType = jsonNotification['type'] as String;
    tweet = Tweet.jsonTweet(jsonNotification['notificationTweet'], false);
  }
  bool type = true;
  String getType() {
    String msg = ' ';
    if (notificationType == 'like') {
      msg = '  liked your tweet';
      type = true;
    } else if (notificationType == 'retweet') {
      msg = '  retweeted your tweet';
      type = true;
    } else if (notificationType == 'block') {
      msg = '  blocked you';
      type = false;
    }
    return msg;
  }

  void _viewTweet(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return NotificationTweet(tweet);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => {_viewTweet(context)},
          leading: userImage, //should be dynamic and fetched from backend
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: username,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: getType(), //notification type fetched from backend
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          subtitle: type
              ? Text(
                  tweet.getTweetText(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ) //the tweet text fetched from backend
              //style: TextStyle(fontSize: 12, color: Colors.blueGrey))
              : Text(''),

          trailing: PopupMenuButton(
            //button to display the see less list
            elevation: 20,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<Text>(
                  child: Text(
                    "See less often", //this is supposed to be static
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ];
            },
          ),
          isThreeLine: true,
        ),
      ],
    );
  }
}
