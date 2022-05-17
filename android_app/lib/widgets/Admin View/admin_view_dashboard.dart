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
            //title: data.name,
            title: '${data.percent.toStringAsFixed(0)}%',
            titleStyle: const TextStyle(
              fontFamily: 'RalewayMedium',
              fontWeight: FontWeight.bold,
              //color: Colors.white,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
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
        SizedBox(height: screenHeight * 0.08),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.08),
            Container(
              width: 300,
              height: 100,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 40,
                  sections: getSections(),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
