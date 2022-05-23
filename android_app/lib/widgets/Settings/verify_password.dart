import 'package:android_app/widgets/Settings/update_email.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import '../bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import './update_phone.dart';

///class that creates a page that verifies the user's current password for extra privacy before changing important information
class VerifyPassword extends StatefulWidget {
  bool ISemail;
  String token;
  String username;
  String email; //needed to send to backend and verify password

  ///function to check validity of input password
  // bool isPasswordValid(var password) {
  //   return _passwordIsValid = password.length >= 8;
  // }

  VerifyPassword(this.ISemail, this.token, this.username, this.email);
  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  String lastValidatedPassword = "";
  String lastRejectedPassword = "";

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

  Future<void> _validateCredentialsAsync(String password) async {
    print('validating password');
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

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  var _password;
  var _passwordIsEntered = false;
  var _passwordIsVisible = false;
  var _passwordIsValid = false;

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
                    if (value.isNotEmpty) {
                      setState(() {
                        _password = value;
                        _passwordIsEntered = true;
                      });
                    }
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
                        if (_passwordKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (widget.ISemail)
                                      ? (context) => UpdateEmail(widget.token,
                                          widget.username, widget.email)
                                      : (context) => UpdatePhone(widget.token,
                                          widget.username, widget.email)));
                        } else {
                          showAlertDialog(context);
                        }
                      },
                      child: Text('Next', style: TextStyle(fontSize: 14)),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Settings(
                            widget.token, widget.username, widget.email)));
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
