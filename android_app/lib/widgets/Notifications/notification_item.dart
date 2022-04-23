import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem();

  String username = "username";
  String notificationType = " ";
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 13.0,
  );

//function to set the list of notifications that we get when we open notifications list
  NotificationItem.jsonNotification(Map<String, dynamic> jsonNotification) {
    username = jsonNotification['username'] as String;
    notificationType = jsonNotification['type'] as String;
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

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
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
                ? const Text(
                    "The liked tweet", //the tweet text fetched from backend
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey))
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
          ),
        ],
      ),
    );
  }
}
