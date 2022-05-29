import 'package:flutter/material.dart';

class UserSearch extends StatelessWidget {
  String username = "username";
  String handle = "@username";
  CircleAvatar userImage = CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 25.0,
  );
  UserSearch(
    this.username,
    this.handle,
    this.userImage,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: userImage,
      title: Text(
        username,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
