import 'package:android_app/widgets/Settings/update_email.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import '../bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import './update_phone.dart';

class VerifyPassword extends StatefulWidget {
  var _passwordIsCorrect = false;
  var password;
  String email;
  var _passwordIsValid = false;
  bool ISemail;

  bool isPasswordValid(var password) {
    return _passwordIsValid = password.length >= 8;
  }

  VerifyPassword(this.password, this.email, this.ISemail);
  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  var _password;

  var _passwordIsVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sirius',
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RalewayMedium',
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 320,
              child: Text(
                'Verify your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: 320,
              child: Text(
                'Re-enter your Sirius password to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 320,
              child: Form(
                key: _passwordKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordIsVisible = !_passwordIsVisible;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: !_passwordIsVisible,
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
                                ? (Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (widget.ISemail)
                                            ? (context) =>
                                                UpdateEmail(widget.email)
                                            : (context) => UpdatePhone())))
                                : showAlertDialog(context));
                      },
                      child: Text('Next', style: TextStyle(fontSize: 14)),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
