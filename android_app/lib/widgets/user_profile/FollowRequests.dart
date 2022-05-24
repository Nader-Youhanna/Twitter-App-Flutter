import 'package:android_app/models/user.dart';
import 'package:android_app/widgets/user_profile/followRequestItem.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
import 'package:android_app/widgets/user_profile/followers_List_scroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'WhoToFollow.dart';
import 'package:android_app/widgets/user_profile/FollowRequests.dart';
import 'package:android_app/widgets/user_profile/requests_list.dart';

class FollowRequests extends StatefulWidget {
  //const FollowRequests({Key? key}) : super(key: key);
  String username;
  String token;

  FollowRequests(this.username, this.token);

  @override
  State<FollowRequests> createState() => _FollowRequestsState();
}

class _FollowRequestsState extends State<FollowRequests> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  List<RequestsItem> Requests = [];

  Future<List<RequestsItem>> getRequests() async {
    List<RequestsItem> followerslist = <RequestsItem>[];

    var data;
    print("fetching Requests");
    //var url = Uri.parse("http://192.168.1.8:3000/BoodyFollowers");
    var url = Uri.parse("http://34.236.108.123:3000/home/Follow-requests");
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
        for (int i = 0; i < data['usersArr'].length; i++) {
          followerslist.add(RequestsItem.jsonFollowRequest(
              data['usersArr'][i], widget.token));
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<RequestsItem> RequestsFetches = await getRequests();
      setState(() {
        Requests = RequestsFetches;
      });
    });
  }

  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          tabBarTheme: TabBarTheme(labelColor: Colors.black)),
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Follower requests',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  _goBack(context);
                },
              ),
            ),
            body: TabBarView(
              children: [RequestsPage(Requests)],
            )),
      ),
    );
  }
}
