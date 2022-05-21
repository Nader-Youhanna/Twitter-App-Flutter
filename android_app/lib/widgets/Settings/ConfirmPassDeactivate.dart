import 'package:android_app/widgets/Settings/Deactivate_account.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/gestures.dart';
import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/LikesTab.dart';

import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';

class ConfirmforDeactivate extends StatefulWidget {
  //const ConfirmforDeactivate({Key? key}) : super(key: key);
  var _passwordIsCorrect = false;
  var _passwordIsValid = false;
  var password;
  String token;
  bool isPasswordValid(var password) {
    return _passwordIsValid = password.length >= 8;
  }

  ConfirmforDeactivate(this.password, this.token);
  @override
  State<ConfirmforDeactivate> createState() => _ConfirmforDeactivateState();
}

class _ConfirmforDeactivateState extends State<ConfirmforDeactivate> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  var _password;
  bool success = false;
  Future<void> Getrequestdeactivate() async {
    var data;
    print("sending deacitvate request");
    var url = Uri.parse("http://192.168.1.8:3000/settings/Deactivate-account");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        data = json.encode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            success = data['success'] as bool;
          });
        }
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error:$e');
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
            title: Text(
              'Sirius',
              style: TextStyle(
                fontSize: 38,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: 'RalewayMedium',
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Settings(widget.token))));
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Confirm your password",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RalewayMedium',
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: Text(
                  'Complete your deactivation request by entering the password associated with your account.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    setState(() {
                      if (_passwordKey.currentState!.validate()) {
                        _password = value;
                        widget._passwordIsValid = true;
                      }
                    });
                  },
                  validator: (value) {
                    if (value != null &&
                        widget.isPasswordValid(value) &&
                        value == widget.password) {
                      widget._passwordIsCorrect = true;
                    } else {
                      return 'Password incorrect';
                    }
                  },
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 280,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _password == null
                              ? (showAlertDialog(context))
                              : (widget._passwordIsCorrect
                                  ? (setState(() {
                                      Getrequestdeactivate();
                                    }))
                                  : showAlertDialog(context));
                        },
                        child:
                            Text('Deactivate', style: TextStyle(fontSize: 17)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///function that creates an Alert dialog with an ok buttin which appears with a specific text and can be discarded by the user
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Password incorrect"),
      content: Text("please re-enter password"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
