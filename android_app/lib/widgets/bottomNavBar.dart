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

List<Tweet> tweets = [
  Tweet(
    'This is the first tweet with one image',
    [
      'assets/images/test_image.png',
    ],
    3,
    5,
  ),
  Tweet(
    'This is the second tweet with two images',
    [
      'assets/images/test_image.png',
      'assets/images/test_image.png',
    ],
    33,
    700,
  ),
  Tweet(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      [
        'assets/images/test_image.png',
        'assets/images/test_image.png',
        'assets/images/test_image.png',
      ],
      1000,
      99000),
  Tweet(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      [
        'assets/images/test_image.png',
        'assets/images/test_image.png',
        'assets/images/test_image.png',
        'assets/images/test_image.png',
      ],
      1000,
      99000),
  Tweet(
    'This tweet has no images',
    [],
    0,
    0,
  ),
];

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  String _appBarText = 'Timeline';

  final List<Widget> _widgetOptions = <Widget>[
    Timeline(tweets),
    //first element should be timeline but i couldn't initialize it
    const Center(
        child: Text('Explore should be here',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight
                    .bold))), //second item should be explore page->not yet created
    const NotificationsPage(),
    Inbox(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _appBarText = 'Timeline';
          break;
        case 1:
          _appBarText = 'Explore';
          break;
        case 2:
          _appBarText = 'Notifications';
          break;
        case 3:
          _appBarText = 'Messages';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar test
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () => {}), //button should open to side bar,
        actions: [
          Container(
            width: 260,
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7.0),
                hintStyle: const TextStyle(
                  fontSize: 14.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: _appBarText,
              ),
            ),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
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
          iconSize: 25,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
