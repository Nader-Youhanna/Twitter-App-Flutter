import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:android_app/constants.dart';
import '../../constants.dart';

///class to create updat email page
class UpdateEmail extends StatefulWidget {
  // const UpdateEmail({Key? key}) : super(key: key);
  static const _widthOfTextFields = 320.0;
  String email;
  String Token;
  var _emailIsValid = false;

  ///function to check validity of email address and that it is in the correct format
  bool isEmailValid(var email) {
    print(email);
    return (_emailIsValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email));
  }

  UpdateEmail(this.email, this.Token);
  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  final GlobalKey<FormState> _mailKey = GlobalKey<FormState>();
  var _emailIsEntered = false;
  String _email = '';
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<void> httpRequestPatch() async {
    var url =
        Uri.parse('http://${MY_IP_ADDRESS}:3000/settings/Account-info/Email');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' +
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNjg4ZWNlOWEzNjc3NWIzNDZlNmE2OCIsImlhdCI6MTY1MjY1MzgyMywiZXhwIjoxNjYxMjkzODIzfQ.UPDwftWISguZHasxOJB9F_Uyltgsi2R9azbwgJqzuno',
      },
      body: json.encode(
        <String, String>{
          "email": "${_email}",
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
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
              'Change email',
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
              'your current email is ${widget.email}. What would you like to update it to? Your email is not displayed in your public profile on Sirius.',
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
              key: _mailKey,
              child: SizedBox(
                width: UpdateEmail._widthOfTextFields,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                    suffixIcon: (widget._emailIsValid && _emailIsEntered)
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          )
                        : (_emailIsEntered && !widget._emailIsValid)
                            ? const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )
                            : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailIsEntered = value.isNotEmpty;
                      if (value.isNotEmpty) {
                        _emailIsEntered = true;
                        _email = value;
                      }
                      if (_mailKey.currentState!.validate()) {
                        _email = value;
                      }
                    });
                  },
                  validator: (value) {
                    if (value != null && widget.isEmailValid(value)) {
                      return null;
                    } else {
                      return 'Please enter a valid email address';
                    }
                  },
                ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _emailIsEntered == false
                          ? (showAlertDialog(context))
                          : (widget._emailIsValid
                              ? (setState(() {
                                  httpRequestPatch();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Settings(widget.Token)));
                                }))
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Settings(widget.Token)));
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontSize: 14),
            ),
          ),
        ]),
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
