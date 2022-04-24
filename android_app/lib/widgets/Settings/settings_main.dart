import 'package:android_app/widgets/Settings/Account_info.dart';
import 'package:android_app/widgets/Settings/Audience.dart';
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

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  String username = "Nada";
  String email = "nadatarek2710@gmail.com";
  String phone = "123";
  String country = "Egypt";
  String Password = "12345678";

  Future<void> httpRequestGet() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/profile');
    var response = await http.get(url);

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      username = extractedMyInfo["username"];
      email = extractedMyInfo["email"];
      phone = extractedMyInfo["phone"];
      country = extractedMyInfo["country"];
    });
  }

  @override
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
                                    username, email, phone, country, Password)),
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
                        onPressed: () {},
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
                                  builder: (context) => Audience()));
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
                        onPressed: () {},
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
                        onPressed: () {},
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
