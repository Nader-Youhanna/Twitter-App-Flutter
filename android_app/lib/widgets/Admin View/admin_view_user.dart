// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AdminViewUser extends StatelessWidget {
  String name = "username";
  String username = "@username";
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 20,
  );
  AdminViewUser(
    this.name,
    this.username,
  );

  AdminViewUser.jsonAdminUser(Map<String, dynamic> jsonAdminUser) {
    name = jsonAdminUser['name'] as String;
    username = jsonAdminUser['username'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      isThreeLine: true,
      leading: userImage,
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            username,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Color.fromARGB(255, 122, 122, 122),
            ),
          ),
          Row(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 3, 136, 8),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(2, 25),
              ),
              onPressed: () {},
              child: Text(
                'statistics',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(2, 25),
              ),
              onPressed: () {},
              child: Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(2, 25),
              ),
              onPressed: () {},
              child: Text(
                'Ban',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: Size(2, 25),
              ),
              onPressed: () {},
              child: Text(
                'Reports',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
