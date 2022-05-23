import 'package:android_app/models/user.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
import 'package:android_app/widgets/user_profile/followers_List_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'WhoToFollow.dart';

///class that shows the followers & following accounts of the user
class Accounts_page extends StatefulWidget {
  //const Accounts_page({Key? key}) : super(key: key);
  String username;
  String token;
  Accounts_page(this.username, this.token);

  @override
  State<Accounts_page> createState() => _Accounts_pageState();
}

class _Accounts_pageState extends State<Accounts_page> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  List<User_Item> followers = [];
  List<User_Item> following = [];

  Future<List<User_Item>> getFollowers() async {
    List<User_Item> followerslist = <User_Item>[];

    var data;
    print("fetching followers");
    //var url = Uri.parse("http://192.168.1.8:3000/BoodyFollowers");
    var url =
        Uri.parse("http://34.236.108.123:3000/${widget.username}/followers");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        for (int i = 0; i < data['followers'].length; i++) {
          followerslist
              .add(User_Item.jsonUserItem(data['followers'][i], widget.token));
//for mock server
          // followers = data.map((e) => User_Item.jsonUserItem(e)).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return followerslist;
  }

  Future<List<User_Item>> getFollowing() async {
    List<User_Item> followinglist = <User_Item>[];
    var data;
    print("fetching following");
    //var url = Uri.parse("http://192.168.1.8:3000/Boodyfollowing");
    var url =
        Uri.parse("http://34.236.108.123:3000/${widget.username}/following");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        for (int i = 0; i < data['following'].length; i++) {
          followinglist
              .add(User_Item.jsonUserItem(data['following'][i], widget.token));
//for mock server
          // followers = data.map((e) => User_Item.jsonUserItem(e)).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return followinglist;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<User_Item> followersfetched = await getFollowers();
      List<User_Item> followingfetched = await getFollowing();
      setState(() {
        followers = followersfetched;
        following = followingfetched;
      });
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
              widget.username,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(widget.username, false, widget.token)));
              },
            ),
            actions: <Widget>[
              IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WhoToFOllow(widget.token)));
                },
                icon: Icon(Icons.add_sharp),
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
