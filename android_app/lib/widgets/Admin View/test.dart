import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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

class Test extends StatelessWidget {
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
    return PieChart(
      PieChartData(
        centerSpaceRadius: 20,
        sections: getSections(),
      ),
    );
  }
}
