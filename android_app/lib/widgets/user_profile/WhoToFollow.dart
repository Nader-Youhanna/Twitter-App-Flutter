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
  //const WhoToFOllow({Key? key}) : super(key: key);
  String token;
  WhoToFOllow(this.token);
  @override
  State<WhoToFOllow> createState() => _WhoToFOllowState();
}

class _WhoToFOllowState extends State<WhoToFOllow> {
  List<User_Item> usersList = [];

  ///function to get a list of suggested users from the server
  Future<List<User_Item>> getUsers() async {
    List<User_Item> userList = <User_Item>[];
    var data;
    print("fetching who to follow");
    //var url = Uri.parse("http://192.168.1.8:3000/Boodyfollowing");
    var url = Uri.parse("http://34.236.108.123:3000/home/Who-to-follow");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      print("${response.statusCode}");
      print("${response.body}");
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        for (int i = 0; i < data['accounts'].length; i++) {
          userList.add(
              User_Item.jsonWhoToFollow(data['accounts'][i], widget.token));
//for mock server
          // followers = data.map((e) => User_Item.jsonUserItem(e)).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return userList;
  }

  // List<User_Item> User_item = [
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", false, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", false, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", false, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  //   User_Item("username", "handle", true, false, "bio"),
  // ];

  void _goBack(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<User_Item> Usersfetched = await getUsers();
      // List<User_Item> followingfetched = await getFollowing();
      setState(() {
        usersList = Usersfetched;
      });
    });
  }

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
        body: SingleChildScrollView(child: Followers_page(usersList)),
      ),
    );
  }
}
