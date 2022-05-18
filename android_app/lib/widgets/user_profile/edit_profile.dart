import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:csc_picker/csc_picker.dart';

///class that creates the edit profile settings page (incomplete)
class Edit_Profile extends StatefulWidget {
  const Edit_Profile({Key? key}) : super(key: key);

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  String HeaderImage = "";
  String profileImage = "";
  String name = "nada";
  String _bio = "this is my bio";
  String country = "Egypt";
  String city = "cairo";
  String website = "www.website.com";
  DateTime birthdate = DateTime.parse("2022-04-25T02:26:31.367Z");
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
        appBar: AppBar(
          title: Text(
            'Edit profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile("", false)),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile("", false)));
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/cover_image_sample.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 115,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 55,
                          child: CircleAvatar(
                            backgroundImage:
                                new AssetImage('assets/images/user_icon.png'),
                            radius: 50,
                            backgroundColor: Colors.grey,
                          )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  width: 320,
                  child: Form(
                      child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    initialValue: "${name}",
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          name = value;
                        }
                      });
                    },
                  )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: Text(
                    "Bio",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  width: 320,
                  child: Form(
                      child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    initialValue: "${_bio}",
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          name = value;
                        }
                      });
                    },
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
