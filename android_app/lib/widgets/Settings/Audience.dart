import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

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
  Future<void> httpRequestPatchPrivate() async {
    var url = Uri.parse(
        "http://${MY_IP_ADDRESS}:3000//settings/Account-info/Protected-tweets");

    //var body = json.encode(reqBody);
    var response = await http.patch(
      url,
      body: null,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + constToken
      },
    );
    print("${response.statusCode}");
    if (response.statusCode == 200) {
      print("${response.body}");
      return json.decode(response.body);
    }
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
                    setState(() {
                      httpRequestPatchPrivate();
                    });
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
