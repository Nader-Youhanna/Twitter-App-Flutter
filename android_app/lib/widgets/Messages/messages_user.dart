import 'package:flutter/material.dart';

class MessagesUser extends StatelessWidget {
  String name = "username";
  String username = "@username";
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 20,
  );
  MessagesUser(
    this.name,
    this.username,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: userImage,
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'RalewayMedium',
        ),
      ),
      subtitle: Text(
        username,
        style: const TextStyle(
          color: Color.fromARGB(255, 122, 122, 122),
        ),
      ),
    );
  }
}
