import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class notificationsSettings extends StatefulWidget {
  // const notificationsSettings({Key? key}) : super(key: key);
  String token;
  String _username = "username";
  String email; //just to navigate
  notificationsSettings(this._username, this.token, this.email);
  @override
  State<notificationsSettings> createState() => _notificationsSettingsState();
}

class _notificationsSettingsState extends State<notificationsSettings> {
  void _goBack(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  bool push_notification = false;

  Future<void> httpRequestPatch() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/settings/Notifications');

    var response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
        body: null);

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
                    text: "Prefrences",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: "${widget._username}",
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
                'Select your prefrences regarding push notifications',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: 'RalewayMedium'),
              ),
            ),
            ListTile(
              title: Text(
                'Push notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RalewayMedium',
                ),
              ),
              trailing: Switch(
                value: push_notification,
                onChanged: (value) {
                  setState(() {
                    push_notification = value;
                    setState(() {
                      httpRequestPatch();
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
                'Allow push notifications to be sent to your device when someone likes, comments or retweets your tweets.',
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
