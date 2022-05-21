// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Tweets/tweet.dart';
import '../user_profile/profile.dart';
import './notification_tweet.dart';

///class to  create the elements that apears in the notifications list
class NotificationItem extends StatelessWidget {
  NotificationItem();

  String username = "username";

  ///the username of the user that triggered the notification
  String notificationType = " ";

  ///the notification type (like, retweet, block)
  late Tweet tweet;
  String tweetID = "";
  String notificationID = "";

  ///the tweet that the notification is concerned with
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 18.0,
  );

//named constructor to map the elements fetched from server
  NotificationItem.jsonNotification(Map<String, dynamic> jsonNotification) {
    username = jsonNotification['sender'] as String;
    notificationType = jsonNotification['activity'] as String;
    // tweet = Tweet.jsonTweet(jsonNotification['notificationTweet'], false, true);
    notificationID = jsonNotification['notificationId'] as String;
    tweetID = jsonNotification['tweetId'] as String;
  }

  ///function that constructs notification string according to the type fetched from server
  String getType() {
    String msg = ' ';
    if (notificationType == 'like') {
      msg = '  liked your tweet';
    } else if (notificationType == 'retweet') {
      msg = '  retweeted your tweet';
    } else if (notificationType == 'tag') {
      msg = '  tagged you in a tweet';
    } else if (notificationType == 'quoteRetweet') {
      msg = '  retweeted with quote on your tweet';
    } else if (notificationType == 'reply') {
      msg = '  replied on your tweet';
    }

    return msg;
  }

  void _goToUserProfile(BuildContext ctx, String user) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile(user, false);
      }),
    );
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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // print("height: $height \n");
    // print("width is $width");
    return Column(
      children: [
        ListTile(
          leading: userImage,
          onTap: () => {_viewTweet(context)},
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: username,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _goToUserProfile(context, username);
                    },
                ),
                TextSpan(
                  text: getType(), //notification type fetched from backend
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          subtitle: Text(
            tweet.getTweetText(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ) //the tweet text fetched from backend
          //style: TextStyle(fontSize: 12, color: Colors.blueGrey))
          ,
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
                        alignment: Alignment.centerLeft,
                        height: height * (100 / 825.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0))),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              minimumSize: MaterialStateProperty.all(
                                  Size.fromHeight(40)),
                              alignment: Alignment.centerLeft,
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            "See less often",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 82, 82, 82),
                                fontStyle: FontStyle.normal),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print("pressed");
                          }, //should be a function to delete notification from list
                        ),
                      );
                    });
              }),
          isThreeLine: true,
        ),
      ],
    );
  }
}
