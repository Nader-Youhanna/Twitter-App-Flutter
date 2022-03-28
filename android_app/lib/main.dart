import 'package:flutter/material.dart';

import './Tweets/tweet.dart';
import './start_page.dart';
import './Log In/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login(),
        //body: StartPage(),
        //body: Tweet(),
      ),
    );
  }
}
