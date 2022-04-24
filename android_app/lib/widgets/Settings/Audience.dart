import 'package:flutter/material.dart';

class Audience extends StatefulWidget {
  const Audience({Key? key}) : super(key: key);

  @override
  State<Audience> createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Audience",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "\n"),
                      TextSpan(
                        text: "@username",
                        style: TextStyle(
                            color: Color.fromARGB(255, 62, 62, 62),
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    _goBack(context);
                  },
                ),
              ))),
    );
  }
}
