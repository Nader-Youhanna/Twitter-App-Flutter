import 'package:android_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
import 'package:android_app/widgets/user_profile/followers_List_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

///class that shows the followers & following accounts of the user
class Accounts_page extends StatefulWidget {
  //const Accounts_page({Key? key}) : super(key: key);
  String username;
  Accounts_page(this.username);

  @override
  State<Accounts_page> createState() => _Accounts_pageState();
}

class _Accounts_pageState extends State<Accounts_page> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  List<User_Item> followers = [];
  List<User_Item> following = [];

  Future<void> getFollowers() async {
    var data = [];
    print("fetching trending topics");
    var url = Uri.parse("http://192.168.1.8:3000/BoodyFollowers");
    // var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/${widget._username}/followers");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        setState(() {
          followers = data.map((e) => User_Item.jsonUserItem(e)).toList();
        });
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  Future<void> getFollowing() async {
    var data = [];
    print("fetching trending topics");
    var url = Uri.parse("http://192.168.1.8:3000/Boodyfollowing");
    // var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/${widget._username}/following");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        setState(() {
          following = data.map((e) => User_Item.jsonUserItem(e)).toList();
        });
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    setState(() {
      getFollowers();
      getFollowing();
    });
  }

  Widget build(BuildContext context) {
    var _tabs = ["Followers", "Following"];

    // List<User_Item> User_item = [
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", false, true, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", false, true, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    //   User_Item("username", "handle", true, false, "bio"),
    // ];

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          tabBarTheme: TabBarTheme(labelColor: Colors.black)),
      home: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "username",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                _goBack(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                color: Colors.black,
                onPressed: () {},
                icon: Icon(Icons.search),
                tooltip: 'search button',
              )
            ],
            bottom: TabBar(
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
            ),
          ),
          body: TabBarView(
              children: [Followers_page(followers), Followers_page(following)]),
        ),
      ),
    );
  }
}
