// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  late TooltipBehavior _tooltipBehavior;
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  late List<UserTweets> userData = <UserTweets>[];
  bool isAndroid = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);

    //userData = getUserTweetStats() as List<UserTweets>;
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData1 = [
      ChartData('Page A', 0),
      ChartData('Page B', 10),
      ChartData('Page C', 15),
      ChartData('Page D', 30),
      ChartData('Page E', 70),
      ChartData('Page F', 120)
    ];
    final List<ChartData> chartData2 = [
      ChartData('Page A', 10),
      ChartData('Page B', 20),
      ChartData('Page C', 15),
      ChartData('Page D', 20),
      ChartData('Page E', 30),
      ChartData('Page F', 5)
    ];
    if (userData != null) {
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
                    child: SfCartesianChart(
                        tooltipBehavior: _tooltipBehavior,
                        legend: Legend(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                          image: AssetImage('assets/images/Arrow.png'),
                          isVisible: true,
                          title: LegendTitle(
                              text: 'Tweets',
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'bold')),
                          position: LegendPosition.top,
                        ),
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<ChartData, String>(
                              enableTooltip: true,
                              legendIconType: LegendIconType.image,
                              name: '20%',
                              dataSource: chartData1,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y)
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: SfCartesianChart(
                        tooltipBehavior: _tooltipBehavior,
                        legend: Legend(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                          ),
                          image: AssetImage('assets/images/Arrow_Down.png'),
                          isVisible: true,
                          title: LegendTitle(
                              text: 'Followers',
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'bold')),
                          position: LegendPosition.top,
                        ),
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<ChartData, String>(
                              enableTooltip: true,
                              legendIconType: LegendIconType.image,
                              name: '30%',
                              dataSource: chartData2,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y)
                        ]),
                  )
                ]),
              )));
    } else
      return Text("no data");
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
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
