import 'package:flutter/material.dart';
import './Notifications/notificationsPage.dart';
import './Log In/login.dart';
import 'Sign Up/sign_up.dart';
import 'Tweets/tweet.dart';
import './timeline.dart';
import './forgot_password.dart';
import 'Messages/inbox.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar();

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  final List<Tweet> tweet = [];
  final List<Widget> _widgetOptions = <Widget>[
    const Center(
        child: Text(
      'Timeline should be here',
      style: TextStyle(
          color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
    )), //first element should be timeline but i couldn't initialize it
    const Center(
        child: Text(
      'Explore should be here',
      style: TextStyle(
          color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
    )), //second item should be explore page->not yet created
    const NotificationsPage(),

    Inbox(), //last item should be messages page->not yet created
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              //first page is the time line
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: 'timeline',
              activeIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              //second page is the epxlore

              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              label: 'explore',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              //thris page is notifications
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              label: 'notifications',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              //last page is messages
              icon: Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              label: 'messages',
              activeIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 20,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
