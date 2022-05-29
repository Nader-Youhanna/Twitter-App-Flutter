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

  //var password;
  String token;
  String username;
  String email; //needed to cofirm password

  ConfirmforDeactivate(this.token, this.username, this.email);
  @override
  State<ConfirmforDeactivate> createState() => _ConfirmforDeactivateState();
}

class _ConfirmforDeactivateState extends State<ConfirmforDeactivate> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  void _goBack(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  String lastValidatedPassword = "";
  String lastRejectedPassword = "";
  var _password;
  var _passwordIsEntered = false;
  var _passwordIsVisible = false;
  var _passwordIsValid = false;

  //var _password;
  String success = "";

  ///functions to validate the credintials of the user before deactivating
  bool _validateCredentials(String password) {
    if (lastValidatedPassword == password) {
      return true;
    } else if (lastRejectedPassword == password) {
      return false;
    } else {
      _validateCredentialsAsync(password);
      return false;
    }
  }

  ///functions to validate the credintials of the user before deactivating
  Future<void> _validateCredentialsAsync(String password) async {
    //Real server response:
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/login');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        <String, String>{
          'email': widget.email,
          'password': password,
        },
      ),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    if (extractedMyInfo['status'] == 'Success') {
      lastValidatedPassword = password;
      print('Success');
      print(lastValidatedPassword);
    } else {
      lastRejectedPassword = password;
    }
    _validateCredentials(password);
    // _passwordKey.currentState!
    //     .validate(); // this will re-initiate the validation

    //MOCK SERVER
    // var url = Uri.parse('http://$MY_IP_ADDRESS:3000/login');
    // var response = await http.get(url);
    // final extractedMyInfo = json.decode(response.body) as List<dynamic>;
    // print(extractedMyInfo);
    // for (int i = 0; i < extractedMyInfo.length; i++) {
    //   if (extractedMyInfo[i]['username'] == widget.username &&
    //       extractedMyInfo[i]['password'] == password) {
    //     widget.name = extractedMyInfo[i]['name'];
    //     lastValidatedPassword = password;
    //   }
    // }
    // lastRejectedPassword = password;

    _passwordKey.currentState!
        .validate(); // this will re-initiate the validation
  }

  ///function to send deactivate request to the server
  Future<void> Getrequestdeactivate() async {
    var data;
    print("sending deacitvate request");
    var url =
        Uri.parse("http://${MY_IP_ADDRESS}:3000/settings/Deactivate-account");
    //var url = Uri.parse("http://192.168.1.8:3000/DeactivateAccount");

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + widget.token
      },
    );
    print("${response.statusCode}");
    print("${response.body}");
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
                _goBack(context);
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
                      if (value.isNotEmpty) {
                        setState(() {
                          _password = value;
                          _passwordIsEntered = true;
                        });
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'incorrect';
                    } else {
                      return _validateCredentials(value)
                          ? null
                          : 'password incorrect';
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
                          setState(() {
                            Getrequestdeactivate();
                          });
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
