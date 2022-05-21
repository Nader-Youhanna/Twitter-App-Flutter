import 'package:flutter/material.dart';

//to have a default value for the avatar
const CircleAvatar userImages = CircleAvatar(
  backgroundImage: AssetImage('assets/images/user_icon2.png'),
  radius: 25.0,
);

///class to create the elements that appear in the search suggestion list (its data is fetched from server)
class SearchItem extends StatelessWidget {
  late String username;
  late String _handle;
  String userID = '';
  CircleAvatar _userImage = userImages;

  late String trends = " ";
  //all data concerning tweets and users are named and optional
  //we will only need them according to set type

  ///named constructor to map the data fetched from servers
  SearchItem.jsonSearchItem(Map<String, dynamic> jsonSearchItem) {
    username = jsonSearchItem['name'] as String;
    _handle = jsonSearchItem['username'] as String;
    userID = jsonSearchItem['_id'] as String;
    //set _userImage
    if (jsonSearchItem['image'] != null) {
      _userImage = CircleAvatar(
        backgroundImage: NetworkImage(jsonSearchItem['image']),
        backgroundColor: Colors.transparent,
        radius: 20.0,
      );
    }
  }

  // trends = jsonSearchItem['trends'] as String;

  @override
  Widget build(BuildContext context) {
    return username == ''
        ? ListTile(
            title: Text(
              trends,
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
