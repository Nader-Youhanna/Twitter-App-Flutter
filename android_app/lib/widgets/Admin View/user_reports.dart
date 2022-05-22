// ignore_for_file: prefer_const_constructors

import 'package:android_app/widgets/Admin%20View/Report.dart';
import 'package:flutter/material.dart';

class UserReports extends StatefulWidget {
  const UserReports({Key? key}) : super(key: key);

  @override
  State<UserReports> createState() => _UserReportsState();
}

class _UserReportsState extends State<UserReports> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 18.0,
  );
  String username1 = "@Remonda_95";
  String username2 = "@Ziadd_hossam";
  String username3 = "@Sohad_hossam";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    print("height: $height \n");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: const Text(
              "User Reports",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                //Icons.abc,
                color: Colors.black,
              ),
              onPressed: () {
                _goBack(context);
              },
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: height * (10 / 825.5)),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('I am not interested in this account',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username1),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username2),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username3),
                    SizedBox(height: height * (10 / 825.5)),
                  ],
                )),
            SizedBox(
              height: height * (20 / 825.5),
            ),
            Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: height * (10 / 825.5)),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('It\' suspicious or spam',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username1),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username2),
                    SizedBox(height: height * (10 / 825.5)),
                  ],
                )),
            SizedBox(
              height: height * (20 / 825.5),
            ),
            Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: height * (10 / 825.5)),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('It appears their account is hacked',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username1),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username3),
                    SizedBox(height: height * (10 / 825.5)),
                  ],
                )),
            SizedBox(
              height: height * (20 / 825.5),
            ),
            Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: height * (10 / 825.5)),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('They pretending to be me or someone else',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username1),
                    SizedBox(height: height * (10 / 825.5)),
                  ],
                )),
            SizedBox(
              height: height * (20 / 825.5),
            ),
            Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: height * (10 / 825.5)),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('Their tweets are abusive or hateful',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username3),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username2),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username3),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username2),
                    SizedBox(height: height * (10 / 825.5)),
                  ],
                )),
            SizedBox(
              height: height * (20 / 825.5),
            ),
            Card(
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: height * (10 / 825.5)),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'They\'re expressing intentions of self-harm or suicide',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username3),
                    SizedBox(height: height * (10 / 825.5)),
                    Report(username2),
                    SizedBox(height: height * (10 / 825.5)),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
