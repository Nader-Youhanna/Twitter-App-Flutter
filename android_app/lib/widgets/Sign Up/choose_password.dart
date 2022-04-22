import 'package:flutter/material.dart';
import '../bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

class ChoosePassword extends StatefulWidget {
  final username, email, dob;
  var _passwordIsValid = false;

  bool isPasswordValid(var password) {
    return _passwordIsValid = password.length >= 8;
  }

  ChoosePassword(
      {@required this.username, @required this.email, @required this.dob});
  @override
  State<ChoosePassword> createState() => _ChoosePasswordState();
}

class _ChoosePasswordState extends State<ChoosePassword> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _sendDataToBackend() async {
    print('Sent data to backend');

    //Bckend Server
    // var url = Uri.parse('http://$MY_IP_ADDRESS:3000/signup');
    // var response = await http.post(url, body: {
    //   'name': widget.username,
    //   'email': widget.email,
    //   'dob': widget.dob,
    //   'password': _password,
    // });
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    //MOCK SERVER
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/login');
    var response = await http.post(url, body: {
      'username': widget.username,
      'email': widget.email,
      'dob': widget.dob,
      'password': _password,
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void _goToTimeline(BuildContext ctx) {
    _sendDataToBackend();
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pop();
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return MyNavigationBar(
          username: widget.username,
          userID: 0,
          isAdmin: false,
        );
      }),
    );
  }

  final _textFieldWidth = 320.0;

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
                const SizedBox(
                  width: 60,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/images/logo_icon.png',
                    width: 120,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 320,
              child: Text(
                'You\'ll need a password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 320,
              child: Text(
                'Make sure it\'s 8 characters or more',
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: _textFieldWidth,
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
                    if (value != null && widget.isPasswordValid(value)) {
                      return null;
                    } else {
                      return 'Password must be 8 characters or more';
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 440),
            const Divider(
              height: 2,
              thickness: 0.9,
            ),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                const SizedBox(width: 280),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: widget._passwordIsValid
                      ? () {
                          _goToTimeline(context);
                        }
                      : () {},
                  style: (!widget._passwordIsValid)
                      ? ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade400),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade600),
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(),
                          ),
                        )
                      : ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
