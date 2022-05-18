// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';
import '../../functions/http_functions.dart';

class UserStatistics extends StatefulWidget {
  const UserStatistics({Key? key}) : super(key: key);

  @override
  State<UserStatistics> createState() => _UserStatisticsState();
}

class _UserStatisticsState extends State<UserStatistics> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  // Future<List<UserTweets>> getUserTweetStats() async {
  //   List<UserTweets> userData = <UserTweets>[];
  //   var data = [];
  //   print("Adding user tweets statistics");
  //   var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/AdminUserStatsTweets");
  //   try {
  //     var response = await http.get(url);
  //     // print('Response body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       data = json.decode(response.body);
  //       if (data != null) {
  //         userData = data.map((e) => UserTweets.jsonUserTweets(e)).toList();
  //       }
  //     } else {
  //       print("fetch error");
  //     }
  //   } on Exception catch (e) {
  //     print('error: $e');
  //   }

  //   return userData;
  // }
  /// This function get the tweets from the [ipAddress] and port [port] of the backend and return the response.
  Future<List<UserTweets>> getUserTweetStats() async {
    print("Adding tweets");
    Map<String, dynamic> headers = {
      "authorization": token,
      "Content-Type": "application/json"
    };
    Map<String, dynamic> mapTweet = await httpRequestGet(
        "http://${MY_IP_ADDRESS}:3000/AdminUserStatsTweets", headers);

    //print("=========" + mapTweet['data'][0].toString());
    List<UserTweets> tweets = <UserTweets>[];
    for (int i = 0; i < mapTweet.length; i++) {
      tweets.add(UserTweets.jsonUserTweets(mapTweet['data'][i]));
    }

    return tweets;
  }

  late List<UserTweets> userData;
  bool isAndroid = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserTweetStats());
    //userData = getUserTweetStats() as List<UserTweets>;
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.5,
                backgroundColor: Colors.white,
                title: const Text(
                  "User Statistics",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    //Icons.abc,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _goBack(context);
                  },
                )),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: SfCartesianChart(),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: SfCartesianChart(),
                )
              ]),
            )));
  }
}

class UserTweets {
  double x = 0;
  double value = 0;
  String name = "Page A";

  UserTweets.jsonUserTweets(Map<String, dynamic> jsonUserTweets) {
    value = jsonUserTweets['value'] as double;
    x = jsonUserTweets['name'] as double;
  }
}
