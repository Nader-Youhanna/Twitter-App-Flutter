import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem();

//set a boolien to know the notification is a retweet, a like, a block, or a following who has tweeted
//all text items amd type should be in constructor
//username and avatar should be in constructor
//all should be fetched in notifications list

  String username = "username"; //should be dynamic and fetched from backend
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage(
        'assets/images/user_icon.png'), //should be dynamic and fetched from backend
    radius: 13.0,
  );

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
                  const TextSpan(
                    text: " liked your tweet", //should be fetched from backend
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            subtitle: const Text(
                "The liked tweet", //the tweet should be fetched from backend
                style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
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
