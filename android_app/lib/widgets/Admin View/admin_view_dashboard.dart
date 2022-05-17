import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'admin_view_main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'statistics_card.dart';

class Data {
  final String name;
  final double percent;
  final Color color;
  Data({required this.name, required this.percent, required this.color});
}

class PieData {
  static List<Data> data = [
    Data(name: 'Blue', percent: 40, color: Colors.blue),
    Data(name: 'Red', percent: 30, color: Colors.red),
    Data(name: 'Yellow', percent: 20, color: Colors.yellow),
    Data(name: 'Green', percent: 10, color: Colors.green),
  ];
}

class AdminViewDashBoard extends StatelessWidget {
  List<PieChartSectionData> getSections() {
    return PieData.data
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
            color: data.color,
            value: data.percent,
            title: '$data.name',
            titleStyle: const TextStyle(
              color: Colors.green,
              fontSize: 18,
            ),
          );
          return MapEntry(index, value);
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              const SizedBox(width: 70),
              StatisticsCard(
                title: 'Users/Day',
                value: '720',
                percentage: '20',
                increase: false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              const SizedBox(width: 70),
              StatisticsCard(
                title: 'Users/Week',
                value: '4,285',
                percentage: '18',
                increase: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // PieChart(
          //   PieChartData(
          //     centerSpaceRadius: 20,
          //     sections: getSections(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
