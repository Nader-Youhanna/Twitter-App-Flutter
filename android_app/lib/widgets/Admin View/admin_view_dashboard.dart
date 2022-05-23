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
    Data(name: '', percent: 30, color: Colors.blue),
    Data(name: '', percent: 30, color: Colors.red),
    Data(name: '', percent: 20, color: Colors.yellow),
    Data(name: '', percent: 10, color: Colors.green),
    Data(name: '', percent: 10, color: Colors.purple),
  ];
}

class AdminViewDashBoard extends StatelessWidget {
  String name = "";
  String userName = "";
  String userImage = '';
  bool isAdmin = false;
  String email = '';
  String token;
  AdminViewDashBoard(
      {required this.name,
      required this.userName,
      required this.userImage,
      required this.isAdmin,
      required this.email,
      required this.token});

  List<PieChartSectionData> getSections() {
    return PieData.data
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
            color: data.color,
            value: data.percent,
            //title: '${data.name} ${data.percent.toStringAsFixed(0)}%',
            title: '',
            titleStyle: const TextStyle(
              fontFamily: 'RalewayMedium',
              fontWeight: FontWeight.bold,
              fontSize: 15,
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
            SizedBox(width: screenWidth * 0.23),
            StatisticsCard(
              title: 'Users/Day',
              value: '720',
              percentage: '20',
              increase: false,
              name: name,
              userName: userName,
              userImage: userImage,
              isAdmin: isAdmin,
              email: email,
              token: token,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            SizedBox(width: screenWidth * 0.23),
            StatisticsCard(
              title: 'Users/Week',
              value: '4,285',
              percentage: '18',
              increase: true,
              name: name,
              userName: userName,
              userImage: userImage,
              isAdmin: isAdmin,
              email: email,
              token: token,
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.06),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.1),
            Container(
              width: 300,
              height: 100,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 30,
                  sections: getSections(),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: screenHeight * 0.05),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.35),
            const Icon(Icons.square, color: Colors.red, size: 22),
            const Text(
              '#Red - 30%',
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.35),
            const Icon(Icons.square, color: Colors.yellow, size: 22),
            const Text(
              '#Yellow - 20%',
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.35),
            const Icon(Icons.square, color: Colors.blue, size: 22),
            const Text(
              '#Blue',
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.35),
            const Icon(Icons.square, color: Colors.green, size: 22),
            const Text(
              '#Green - 10%',
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.35),
            const Icon(Icons.square, color: Colors.purple, size: 22),
            const Text(
              '#Purple - 10%',
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
