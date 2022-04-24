import 'package:flutter/material.dart';
import './admin_view_dashboard.dart';
import './admin_view_users.dart';

class AdminViewMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.dashboard),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            title: const Text(
              'Admin View',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'RalewayMedium',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AdminViewDashBoard(),
              AdminViewUsers(),
            ],
          ),
        ),
      ),
    );
  }
}
