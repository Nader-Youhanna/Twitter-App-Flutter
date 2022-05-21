import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

///class to create the change password settings page
class ChangePassword extends StatefulWidget {
  //String Password;
  var _passwordIsValid = false;
  String Token;
  String username;
  String email; //to confirm pass

  ///function to check validity of password (>=8  characters)

  bool isPasswordValid(var password) {
    return _passwordIsValid = password.length >= 8;
  }

  ChangePassword(this.Token, this.username, this.email);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newpasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _currentpasswordKey = GlobalKey<FormState>();

  String lastValidatedPassword = "";
  String lastRejectedPassword = "";
  //var _password;
  var _passwordIsEntered = false;
  var _passwordIsValid = false;

  var _Currentpassword;
  var _newPassword;
  final _textFieldWidth = 320.0;
  var _passwordIsVisible = false;
  bool _passwordIsCorrect = false;

  ///function to post the new password into the mock server
  // Future<void> httpRequestPost() async {
  //   var url = Uri.parse('http://$MY_IP_ADDRESS:3000/profile');
  //   var response = await http.post(url, body: {'password': '${_newPassword}'});
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }

  bool _validateCredentials(String password) {
    if (lastValidatedPassword == password) {
      _passwordIsCorrect = true;
      return true;
    } else if (lastRejectedPassword == password) {
      return false;
    } else {
      _validateCredentialsAsync(password);
      return false;
    }
  }

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

    _passwordKey.currentState!
        .validate(); // this will re-initiate the validation
  }

  Future<void> httpRequestPatchnewPassword() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/reset-password');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
      body: json.encode(
        <String, String>{
          "password": "${_newPassword}",
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  ///function to navigate to previous page
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
                "Update password",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      if (widget._passwordIsValid &&
                          _passwordKey.currentState!.validate()) {
                        setState(() {
                          //httpRequestPost();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings(
                                      token, widget.username, widget.email)));
                        });
                      } else {
                        showAlertDialog(context);
                      }
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
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Current password",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 320,
                    child: Form(
                      key: _passwordKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (() {
                              setState(
                                () {
                                  _passwordIsVisible = !_passwordIsVisible;
                                },
                              );
                            }),
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        obscureText: !_passwordIsVisible,
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              _Currentpassword = value;
                              _passwordIsEntered = true;
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Incorrect';
                          } else {
                            return _validateCredentials(value)
                                ? null
                                : 'Username or password is Invalid';
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "New password",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 320,
                    child: Form(
                      key: _newpasswordKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'At least 8 characters',
                          suffixIcon: IconButton(
                            onPressed: (() {
                              setState(
                                () {
                                  _passwordIsVisible = !_passwordIsVisible;
                                },
                              );
                            }),
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                        obscureText: !_passwordIsVisible,
                        onChanged: (value) {
                          setState(() {
                            if (_newpasswordKey.currentState!.validate()) {
                              _newPassword = value;
                            }
                          });
                        },
                        validator: (value) {
                          if (value != null && widget.isPasswordValid(value)) {
                            _newPassword = value;
                          } else {
                            return 'must be 8 characters or above';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ))),
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
      content: Text("please re-confirm password"),
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
