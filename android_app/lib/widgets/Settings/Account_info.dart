import 'package:android_app/widgets/Settings/update_username.dart';
import 'package:android_app/widgets/Settings/verify_password.dart';
import 'package:android_app/widgets/start_page.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

///class to create Account information page to update the user's account information(username,email,phone,country,password)
class AccountInfo extends StatefulWidget {
  String username;
  String email;
  String phone;
  String country;
  // var password;
  String Token;
  AccountInfo(this.username, this.email, this.phone, this.country, this.Token);
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
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
                    text: "Your account",
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Update_username(
                              widget.username, widget.Token, widget.email)));
                },
                child: ListTile(
                    title: Text(
                      'Username',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    trailing: Text('${widget.username}')),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerifyPassword(false,
                              widget.Token, widget.username, widget.email)));
                },
                child: ListTile(
                    title: Text(
                      'Phone',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    trailing: Text('${widget.phone}')),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerifyPassword(true,
                              widget.Token, widget.username, widget.email)));
                },
                child: ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    trailing: Icon(Icons.email)),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                    title: Text(
                      'Country',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    trailing: Text('${widget.country}')),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: TextButton(
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StartPage()));
                  },
                ))
              ])
            ],
          ),
        ));
  }
}
