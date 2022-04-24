import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'package:country_code_picker/country_code_picker.dart';

class UpdatePhone extends StatefulWidget {
  const UpdatePhone({Key? key}) : super(key: key);

  @override
  State<UpdatePhone> createState() => _UpdatePhoneState();
}

class _UpdatePhoneState extends State<UpdatePhone> {
  var _isPhoneEntered = false;
  String _phone = '';
  Future<void> httpRequestPost() async {
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/profile');
    var response = await http.post(url, body: {'phone': '${_phone}'});
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
                              httpRequestPost();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings()));
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
                  context, MaterialPageRoute(builder: (context) => Settings()));
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
