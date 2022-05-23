import 'package:flutter/material.dart';

class MessagesUser extends StatelessWidget {
  double screenHeight = 0;
  double screenWidth = 0;
  String name = "username";
  String username = "@username";
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 20,
  );
  MessagesUser({
    required this.name,
    required this.username,
  });
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
        '@$username',
        style: const TextStyle(
          color: Color.fromARGB(255, 122, 122, 122),
        ),
      ),
    );
  }
}
