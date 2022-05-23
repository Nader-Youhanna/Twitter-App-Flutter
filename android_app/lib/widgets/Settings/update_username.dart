import 'package:flutter/material.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

///class to create the update username settings page
class Update_username extends StatefulWidget {
  // const Update_username({Key? key}) : super(key: key);
  var _username;
  String email; //only needed to navigate back to settings
  String token;
  Update_username(this._username, this.token, this.email);
  @override
  State<Update_username> createState() => _Update_usernameState();
}

class _Update_usernameState extends State<Update_username> {
  //const Update_username({Key? key}) : super(key: key);
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  var _nameIsEntered = false;
  String username = "";

  ///function to check validity of name and whether it has a match in the server

  ///function to send post request to server with the new username
  Future<void> httpRequestPatch() async {
    print('patch change username');
    var url = Uri.parse(
        'http://${MY_IP_ADDRESS}:3000/settings/Account-info/Username');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + widget.token,
      },
      body: json.encode(
        <String, String>{
          "username": "${widget._username}",
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
  }

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
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            leading: TextButton(
              child: Expanded(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
              onPressed: () {
                _goBack(context);
              },
            ),
            title: Text(
              "Update username",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      setState(() {
                        httpRequestPatch();
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Settings(widget.token,
                                  widget._username, widget.email)));
                    });
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Current",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget._username}",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //padding: EdgeInsets.only(top: 20),
                  children: <Widget>[
                    Text(
                      'New',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ]),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                //mainAxisAlignment: MainAxisAlignment.start,
                child: Form(
                  child: SizedBox(
                    width: 320,
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (_nameIsEntered)
                            ? Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_nameIsEntered)
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nameIsEntered = value.isNotEmpty;

                          widget._username = value;
                        });
                      },
                      validator: (value) {
                        if (value != null) {
                          return null;
                        } else {
                          return 'This username is already taken';
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
