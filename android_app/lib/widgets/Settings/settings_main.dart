import 'package:android_app/widgets/Settings/Account_info.dart';
import 'package:android_app/widgets/Settings/Audience.dart';
import 'package:android_app/widgets/Settings/Change_password.dart';
import 'package:android_app/widgets/Settings/Deactivate_account.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import '../../constants.dart';
import 'package:android_app/widgets/Settings/notifications_settings.dart';

///class to create settings page with navigators to each settings options
class Settings extends StatefulWidget {
  //const Settings({Key? key}) : super(key: key);
  String token;
  String _username;
  String email = "nadatarek2710@gmail.com";
  Settings(this.token, this._username, this.email);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  late String Name = "Nada";
  String phone = "123";
  late String country = "Egypt";
  //String Password = "12345678";
  late bool isPrivate = false;

  ///function to fetch user data from mock server (username, email, phone and country)
  Future<void> getuserData() async {
    var data;
    print("getting user data");
    var url = Uri.parse("http://34.236.108.123:3000/${widget._username}");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            //username = data['username'] as String;
            Name = data['name'] as String;
            isPrivate = data['protectedTweets'] as bool;
            country = data['country'] as String;
            //city = data['city'] as String;
            //website = data['website'] as String;
          });
        }
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    setState(() {
      getuserData();
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            tabBarTheme: TabBarTheme(labelColor: Colors.black)),
        home: Scaffold(
          appBar: AppBar(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: "@username",
                    style: TextStyle(
                        color: Color.fromARGB(255, 62, 62, 62), fontSize: 14),
                  )
                ],
              ),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                _goBack(context);
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'Account information',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        'See your account information like your phone number and email address.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountInfo(
                                    widget._username,
                                    widget.email,
                                    phone,
                                    country,
                                    widget.token)),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.key),
                      title: Text(
                        'Change your password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        'Change your password at any time.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword(
                                    widget.token,
                                    widget._username,
                                    widget.email)),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text(
                        'Audience',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        'Manage what information you allow other people on twitter to see.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Audience(isPrivate, widget.token)));
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications_on),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        'Select the kind of notifications you get.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => notificationsSettings(
                                      widget._username,
                                      widget.token,
                                      widget.email)));
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.heart_broken),
                      title: Text(
                        'Deactivate your account',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        'Find out how you can deactivate your account.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Deactivate(
                                      Name,
                                      widget._username,
                                      isPrivate,
                                      widget.token,
                                      widget.email)));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
