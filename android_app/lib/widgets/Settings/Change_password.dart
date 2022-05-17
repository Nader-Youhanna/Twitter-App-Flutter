import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

///class to create the change password settings page
class ChangePassword extends StatefulWidget {
  String Password;
  var _passwordIsValid = false;
  String Token;

  ///function to check validity of password (>=8  characters)
  bool isPasswordValid(var password) {
    return _passwordIsValid = password.length >= 8;
  }

  ChangePassword(this.Password, this.Token);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newpasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _currentpasswordKey = GlobalKey<FormState>();

  var _Currentpassword;
  var _newPassword;
  var _ConfirmePassword;
  final _textFieldWidth = 320.0;
  var _passwordIsVisible = false;
  bool _passwordIsCorrect = false;

  ///function to post the new password into the mock server
  Future<void> httpRequestPost() async {
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/profile');
    var response = await http.post(url, body: {'password': '${_newPassword}'});
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
                      if (_Currentpassword == widget.Password &&
                          _ConfirmePassword == _newPassword) {
                        setState(() {
                          httpRequestPost();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Settings(widget.Token)));
                        });
                      } else {
                        if (_ConfirmePassword != _newPassword) {
                          showAlertDialog(context);
                        }
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
                            if (_passwordKey.currentState!.validate()) {
                              _Currentpassword = value;
                            }
                          });
                        },
                        validator: (value) {
                          if (value != null &&
                              widget.isPasswordValid(value) &&
                              widget.Password == value) {
                            _passwordIsCorrect = true;
                          } else {
                            return 'Current password incorrect';
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
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Confirm password",
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
                      key: _currentpasswordKey,
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
                            if (_currentpasswordKey.currentState!.validate()) {
                              _ConfirmePassword = value;
                            }
                          });
                        },
                        validator: (value) {
                          if (value != null &&
                              widget.isPasswordValid(value) &&
                              _newPassword == value) {
                            print('${_ConfirmePassword}');
                          } else {
                            return 'Passwords do not match';
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
