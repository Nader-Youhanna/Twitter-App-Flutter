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

  Future<List<UserTweets>> getUserTweetStats() async {
    List<UserTweets> userData = <UserTweets>[];
    var data = [];
    print("Adding user tweets statistics");
    var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/AdminUserStatsTweets");
    try {
      var response = await http.get(url);
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        if (data != null) {
          userData = data.map((e) => UserTweets.jsonUserTweets(e)).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }

    return userData;
  }

  late List<UserTweets> userData = <UserTweets>[];
  bool isAndroid = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserTweetStats());
    //userData = getUserTweetStats() as List<UserTweets>;
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);

    getUserTweetStats().then((usersData) {
      userData = usersData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData != null) {
      print(userData);
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
    } else
      return Text("no data");
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
