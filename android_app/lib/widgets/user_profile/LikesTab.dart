import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:android_app/functions/tweet_functions.dart';

import '../../constants.dart';

/// This class is used to represent the timeline page.
class LikesTab extends StatefulWidget {
  List<Tweet> tweets = <Tweet>[];

  String _name = "";
  String _username = "";

  LikesTab(this._name, this._username);
  @override
  State<LikesTab> createState() => _LikesTabState();
}

class _LikesTabState extends State<LikesTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getuserData() async {
    var data;
    print("getting user data");
    var url = Uri.parse("http://192.168.1.8:3000/${widget._username}/likes");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            widget.tweets = data['likes'] as List<Tweet>;
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
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        child: RefreshIndicator(
          onRefresh: () => _refresh(),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return widget.tweets[index];
            },
            itemCount: widget.tweets.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //add tweet
        onPressed: () => startAddTweet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getuserData();
    });
  }

  Future<void> _refresh() async {
    setState(() {
      getuserData();
    });
  }
}
