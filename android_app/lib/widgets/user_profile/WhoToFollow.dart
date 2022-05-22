import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:android_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
import 'package:android_app/widgets/user_profile/followers_List_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

class WhoToFOllow extends StatefulWidget {
  const WhoToFOllow({Key? key}) : super(key: key);

  @override
  State<WhoToFOllow> createState() => _WhoToFOllowState();
}

class _WhoToFOllowState extends State<WhoToFOllow> {
  List<User_Item> User_item = [
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", false, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", false, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", false, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
    User_Item("username", "handle", true, false, "bio"),
  ];

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
        tabBarTheme: TabBarTheme(labelColor: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Connect',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              _goBack(context);
            },
          ),
        ),
        body: SingleChildScrollView(child: Followers_page(User_item)),
      ),
    );
  }
}
