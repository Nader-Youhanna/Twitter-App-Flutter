import 'package:flutter/material.dart';
import './widgets/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StartPage(),
      ),
    );
  }
}
