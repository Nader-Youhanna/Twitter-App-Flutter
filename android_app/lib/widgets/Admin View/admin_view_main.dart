import 'package:flutter/material.dart';
import './admin_view_dashboard.dart';
import './admin_view_users.dart';

class AdminViewMain extends StatelessWidget {
  int selectedIndex = 0;
  String name = "";
  String userName = "";
  String userImage = '';
  bool isAdmin = false;
  String email = '';
  String token;
  AdminViewMain(
      {required this.selectedIndex,
      required this.name,
      required this.userName,
      required this.userImage,
      required this.isAdmin,
      required this.email,
      required this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: selectedIndex,
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
              AdminViewUsers(
                name: name,
                userName: userName,
                userImage: userImage,
                isAdmin: isAdmin,
                email: email,
                token: token,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
