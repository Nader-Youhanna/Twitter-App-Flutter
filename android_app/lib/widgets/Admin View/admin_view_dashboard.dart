import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'admin_view_main.dart';
import 'statistics_card.dart';

class AdminViewDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              StatisticsCard(
                title: 'Users/Day',
                value: '720',
                percentage: '20',
                increase: false,
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              const SizedBox(width: 20),
              StatisticsCard(
                title: 'Users/Week',
                value: '4,285',
                percentage: '18',
                increase: true,
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
