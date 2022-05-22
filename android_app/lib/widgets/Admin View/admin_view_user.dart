// ignore_for_file: prefer_const_constructors

import 'package:android_app/widgets/Admin%20View/user_reports.dart';
import 'package:android_app/widgets/Admin%20View/user_statistics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../user_profile/profile.dart';

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
  bool isDeleted = false;
  AdminViewUser.jsonAdminUser(Map<String, dynamic> jsonAdminUser) {
    name = jsonAdminUser['name'] as String;
    username = jsonAdminUser['username'] as String;
  }

  void _goToUserStatistics(BuildContext ctx, String user) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return UserStatistics();
      }),
    );
  }

  void _goToUserReports(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return UserReports();
      }),
    );
  }

  void _goToUserProfile(BuildContext ctx, String user) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile(user, false);
      }),
    );
  }

  void _banUser(BuildContext context, double width) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Ban this user?'),
            content:
                const Text('This can\'t be undone and you\'ll ban this user'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(45, 35),
                ),
                onPressed: () {
                  isDeleted = true;
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Ban',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: isAndroid ? width * (120 / 329.7) : 200,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(25, 35),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }

  bool isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
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
      subtitle: isAndroid
          ? Column(
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
                    onPressed: () {
                      _goToUserStatistics(context, name);
                    },
                    child: Text(
                      'Statistics',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    width: isAndroid ? width * (6 / 329.7) : 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(2, 25),
                    ),
                    onPressed: () {
                      _goToUserProfile(context, name);
                    },
                    child: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    width: isAndroid ? width * (6 / 329.7) : 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(2, 25),
                    ),
                    onPressed: () {
                      _banUser(context, width);
                    },
                    child: Text(
                      'Ban',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    width: isAndroid ? width * (6 / 329.7) : 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(2, 25),
                    ),
                    onPressed: () {
                      _goToUserReports(context);
                    },
                    child: Text(
                      'Reports',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  )
                ]),
              ],
            )
          : Text(
              username,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Color.fromARGB(255, 122, 122, 122),
              ),
            ),
      trailing: !isAndroid
          ? Row(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 3, 136, 8),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(2, 35),
                ),
                onPressed: () {
                  _goToUserStatistics(context, name);
                },
                child: Text(
                  'Statistics',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                width: isAndroid ? width * (6 / 329.7) : 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(2, 35),
                ),
                onPressed: () {
                  _goToUserProfile(context, name);
                },
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                width: isAndroid ? width * (6 / 329.7) : 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(2, 35),
                ),
                onPressed: () {
                  _banUser(context, width);
                },
                child: Text(
                  'Ban',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                width: isAndroid ? width * (6 / 329.7) : 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(2, 35),
                ),
                onPressed: () {
                  _goToUserReports(context);
                },
                child: Text(
                  'Reports',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(width: 40),
            ])
          : SizedBox(width: 0, height: 0),
    );
  }
}
