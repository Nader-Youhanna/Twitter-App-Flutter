import 'package:flutter/material.dart';
import './terms_and_conditions.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:android_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ConfirmEmail extends StatefulWidget {
  var username;
  var email;
  var dob;
  var name;

  ConfirmEmail({
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.dob,
  });

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  var _code = '0';
  var _codeIsValid = false;
  var _codeIsEntered = false;
  String _token = '';

  Future<void> verifyEmail() async {
    // setState(
    //   () {
    //     //if (_code == '123456') _codeIsValid = true;
    //     _codeIsValid = true;
    //     return;
    //   },
    // );
    // return;

    //BACKEND REQUEST
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/signup-confirm/$_code');
    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        <String, String>{},
      ),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(
      () {
        final extractedMyInfo =
            json.decode(response.body) as Map<String, dynamic>;
        if (extractedMyInfo['status'] == 'Success') {
          _codeIsValid = true;
          _token = extractedMyInfo['token'];
          print('TOKEN = ');
          print(_token);
        } else {
          _codeIsValid = false;
        }
      },
    );
  }

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _goToTermsAndConditions(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return TermsAndConditions(
          name: widget.name,
          username: widget.username,
          email: widget.email,
          dob: widget.dob,
          token: _token,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 29,
                  ),
                  onPressed: () {
                    _goBack(context);
                  },
                ),

                //New logo
                const SizedBox(
                  width: 70,
                ),
                const Text(
                  'Sirius',
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RalewayMedium',
                  ),
                ),

                //Old logo
                // const SizedBox(
                //   width: 60,
                // ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(18),
                //   child: Image.asset(
                //     'assets/images/logo_icon.png',
                //     width: 120,
                //     height: 50,
                //     fit: BoxFit.fill,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 100),
            const Text('''Please copy and paste the 6-digit verification code.
            that has been sent to your e-mail'''),
            const SizedBox(height: 30),

            Container(
              width: 300,
              child: TextField(
                onChanged: (value) {
                  _code = value;
                  _codeIsEntered = true;
                },
              ),
            ),

            //---------------VERIFICATION CODE-----------------------
            // VerificationCode(
            //   textStyle: const TextStyle(
            //     color: Colors.blue,
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   length: 6,
            //   keyboardType: TextInputType.number,
            //   cursorColor: Colors.blue,
            //   clearAll: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Text(
            //       'Clear All',
            //       style: TextStyle(
            //           fontSize: 14.0,
            //           decoration: TextDecoration.underline,
            //           color: Colors.blue),
            //     ),
            //   ),
            //   onCompleted: (String value) {
            //     _code = value;
            //   },
            //   onEditing: (_) {},
            // ),
            const SizedBox(height: 30),
            _codeIsEntered
                ? _codeIsValid
                    ? const Text('')
                    : const Text(
                        'Invalid Code',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontFamily: 'RalewayMedium',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                : const Text(''),
            const SizedBox(height: 180),
            ElevatedButton(
              child: const Text('Enter'),
              onPressed: () async {
                _codeIsEntered = true;
                await verifyEmail();
                if (_codeIsValid) {
                  _goToTermsAndConditions(context);
                }
                print(
                    "Code: $_code\nCode is entered: $_codeIsEntered\nCode is valid: $_codeIsValid");
              },
            ),
          ],
        ),
      ),
    );
  }
}
