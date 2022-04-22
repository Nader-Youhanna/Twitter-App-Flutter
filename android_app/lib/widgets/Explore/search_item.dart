import 'package:flutter/material.dart';

//to have a default value for the avatar
const CircleAvatar userImages = const CircleAvatar(
  backgroundImage: AssetImage('assets/images/user_icon.png'),
  radius: 25.0,
);

class SearchItem extends StatelessWidget {
  String username;
  String handle;
  CircleAvatar userImage;
  int type = 0;
  String tweetText;
  //all data concerning tweets and users are named and optional
  //we will only need them according to set type
  SearchItem(this.type,
      {this.tweetText = '',
      this.username = '',
      this.handle = '',
      this.userImage = userImages});

  @override
  Widget build(BuildContext context) {
    return type == 0
        ? ListTile(
            title: Text(
              tweetText,
              style: TextStyle(color: Colors.black),
            ),
          )
        : ListTile(
            leading: userImage,
            title: Text(
              username,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: Text(
              handle,
              style: TextStyle(
                color: Color.fromARGB(255, 123, 122, 122),
              ),
            ),
          );
  }
}
