// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

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
    var url = Uri.parse("http://$MY_IP_ADDRESS:3000/AdminUserStatsTweets");
    Map<String, dynamic> headers = {
      "Authorization": "Bearer " + constToken,
      "Content-Type": "application/json"
    };
    var request = http.Request('GET', url);
    if (headers != null) {
      request.headers['Content-Type'] = headers['Content-Type'];
      request.headers['Authorization'] = headers['Authorization'];
    }
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    var mapData = json.decode(response.body);
    for (int i = 0; i < mapData.length; i++) {
      userData.add(UserTweets.jsonUserTweets(mapData[i]));
    }

    return userData;
  }

  late List<UserTweets> userData = <UserTweets>[];
  bool isAndroid = true;
  void setData() async {
    userData = await getUserTweetStats();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserTweetStats());
    //userData = getUserTweetStats() as List<UserTweets>;
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
    setState(() {
      setData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("testing user data");
    if (userData != null) {
      print("printingt");
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
    value = checkDouble(jsonUserTweets['value']);
    x = checkDouble(jsonUserTweets['name']);
  }
  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }
}
