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
import 'package:android_app/constants.dart';
import 'package:android_app/functions/http_functions.dart';

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
  String city = "";
  String website = "www.website.com";
  DateTime birthdate = DateTime.parse("2022-04-25T02:26:31.367Z");

  Future PickDate(BuildContext context) async {
    final newdate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 05, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (newdate == null) return;

    setState(() {
      birthdate = newdate;
    });
  }

  Future<void> getData(String ipAddress, String port) async {
    Map<String, dynamic> headers = {
      "authorization": token,
      "Content-Type": "application/json"
    };
    Map<String, dynamic> mapData = await httpRequestGet(
        "http://" + ipAddress + ":" + port + "/settings/profile", headers);

    if (mapData != null) {
      HeaderImage = mapData['headerImage'] as String;
      birthdate = DateTime.parse(mapData['birthdate'] as String);
      name = mapData['name'] as String;
      profileImage = mapData['image'] as String;
      city = mapData['city'] as String;
      country = mapData['country'] as String;
      _bio = mapData['bio'] as String;
      website = mapData['website'] as String;
    }
  }

  Future<void> httprequestpatch() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/settings/profile');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' +
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNjg4ZWNlOWEzNjc3NWIzNDZlNmE2OCIsImlhdCI6MTY1MjY1MzgyMywiZXhwIjoxNjYxMjkzODIzfQ.UPDwftWISguZHasxOJB9F_Uyltgsi2R9azbwgJqzuno',
      },
      body: json.encode(
        <String, String>{
          "name": "${name}",
          "bio": "${_bio}",
          "country": "${country}",
          "city": "${city}",
          "website": "${website}",
          "birthdate": birthdate.toString()
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      getData(MY_IP_ADDRESS, "3000");
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                httprequestpatch();
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
        body: SingleChildScrollView(
          child: Column(
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
                            radius: 45,
                            child: CircleAvatar(
                              backgroundImage:
                                  new AssetImage('assets/images/user_icon.png'),
                              radius: 40,
                              backgroundColor: Colors.grey,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
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
                    width: 250,
                    child: Form(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Add your name"),
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
                    width: 250,
                    child: Form(
                        child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Add a bio to your profile"),
                      textAlignVertical: TextAlignVertical.bottom,
                      initialValue: "${_bio}",
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _bio = value;
                          }
                        });
                      },
                    )),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                    child: Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    width: 200,
                    child: CSCPicker(
                      layout: Layout.horizontal,
                      countrySearchPlaceholder: "Country",
                      citySearchPlaceholder: "City",
                      countryDropdownLabel: "*Country",
                      cityDropdownLabel: "*City",
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      onCountryChanged: (value) {
                        setState(() {
                          country = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          city = value.toString();
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                    child: Text(
                      "Website",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    width: 250,
                    child: Form(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Add your website"),
                      textAlignVertical: TextAlignVertical.bottom,
                      initialValue: "${website}",
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            website = value;
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
                      "Birth date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  GestureDetector(
                      onTap: () {
                        PickDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '${birthdate.month}/${birthdate.day}/${birthdate.year}',
                          style: TextStyle(
                            fontFamily: 'RalewayMedium',
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
