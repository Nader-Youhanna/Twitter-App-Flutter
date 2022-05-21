import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'package:country_code_picker/country_code_picker.dart';

///class to create the update phone settings page
class UpdatePhone extends StatefulWidget {
  //const UpdatePhone({Key? key}) : super(key: key);
  String token;
  String username;
  final String email; //just to nav
  UpdatePhone(this.token, this.username, this.email);
  @override
  State<UpdatePhone> createState() => _UpdatePhoneState();
}

class _UpdatePhoneState extends State<UpdatePhone> {
  var _isPhoneEntered = false;
  String _phone = '';

  ///function to send post request for the updated phone number to the mock server
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
          "email": "${_phone}",
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
              'Add a phone number',
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
              'Enter a phone number you\'d like to associate with your Sirius account. You\'ll get a verification code sent here.',
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
              child: CountryCodePicker(
                initialSelection: 'EG',
              )),
          SizedBox(
            width: 320,
            child: Form(
              // key: _mailKey,
              child: SizedBox(
                width: 320,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Your phone number',
                    labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isPhoneEntered = value.isNotEmpty;
                      if (value.isNotEmpty) {
                        _isPhoneEntered = true;
                        _phone = value;
                      }
                    });
                  },
                  validator: (value) {
                    if (value != null) {
                      return null;
                    } else {
                      return 'Please enter a valid phone number';
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
                      _isPhoneEntered == false
                          ? (showAlertDialog(context))
                          : (setState(() {
                              httpRequestPatch();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings(
                                          widget.token,
                                          widget.username,
                                          widget.email)));
                            }));
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
