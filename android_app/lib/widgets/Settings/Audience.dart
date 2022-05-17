import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///class to create Audience settings page which allows the user to choose priavcy of their account
class Audience extends StatefulWidget {
  //const Audience({Key? key}) : super(key: key);
  bool isPrivate = false;
  String token;
  Audience(this.isPrivate, this.token);
  @override
  State<Audience> createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  ///function to fetch data from mock server
  Future<void> httpRequestPost() async {
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/profile');
    var response =
        await http.post(url, body: {'protected': '${widget.isPrivate}'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
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
                        color: Color.fromARGB(255, 62, 62, 62), fontSize: 14),
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
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const SizedBox(
              width: 320,
              child: Text(
                'Manage what information you allow other people on Sirius to see.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: 'RalewayMedium'),
              ),
            ),
            ListTile(
              title: Text(
                'Protect your Tweets',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RalewayMedium',
                ),
              ),
              trailing: Switch(
                value: widget.isPrivate,
                onChanged: (value) {
                  setState(() {
                    widget.isPrivate = value;
                    httpRequestPost();
                  });
                },
                activeTrackColor: Colors.green,
                activeColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 320,
              child: Text(
                'Only show your Tweets to people who follow you.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: 'RalewayMedium'),
              ),
            )
          ],
        )),
      ),
    );
  }
}
