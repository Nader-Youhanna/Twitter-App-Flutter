import 'package:flutter/material.dart';

//to have a default value for the avatar
const CircleAvatar userImages = const CircleAvatar(
  backgroundImage: AssetImage('assets/images/user_icon.png'),
  radius: 25.0,
);

class SearchItem extends StatelessWidget {
  late String username;
  late String _handle;
  CircleAvatar _userImage = userImages;

  late String tweetText;
  //all data concerning tweets and users are named and optional
  //we will only need them according to set type
  // SearchItem(
  //     {this.tweetText = '',
  //     this.username = '',
  //     this.handle = '',
  //     this.userImage = userImages});
  SearchItem.jsonSearchItem(Map<String, dynamic> jsonSearchItem) {
    // _tweetText = jsonSearchItem['tweetText'] as String;
    username = jsonSearchItem['username'] as String;
    _handle = jsonSearchItem['handle'] as String;
  }
  @override
  Widget build(BuildContext context) {
    return username == ''
        ? ListTile(
            title: Text(
              tweetText,
              style: TextStyle(color: Colors.black),
            ),
          )
        : ListTile(
            leading: _userImage,
            title: Text(
              username,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: Text(
              _handle,
              style: TextStyle(
                color: Color.fromARGB(255, 123, 122, 122),
              ),
            ),
          );
  }
}
