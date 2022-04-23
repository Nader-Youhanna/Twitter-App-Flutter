import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_nav_bar.dart';
import '../../constants.dart';
import 'forgot_password.dart';

class EnterPasswordPage extends StatefulWidget {
  final username;
  final email;

  EnterPasswordPage({
    @required this.username,
    @required this.email,
  });

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  String lastValidatedPassword = "";
  String lastRejectedPassword = "";

  bool _validateCredentials(String password) {
    //TO BE REMOVED IN DISCUSSION
    return true;

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
    //Real server response:
    // var url = Uri.parse('http://$MY_IP_ADDRESS:3000/login');
    // var response = await http.post(url, body: {
    //   'username': widget.username,
    //   'password': password,
    // });
    // print('Response body: ${response.body}');

    // final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    // if (extractedMyInfo[0]['success'] == 'true') {
    //   lastValidatedPassword = password;
    // } else {
    //   lastRejectedPassword = password;
    // }
    // _passwordKey.currentState!
    //     .validate(); // this will re-initiate the validation

    //MOCK SERVER
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/login');
    var response = await http.get(url);
    final extractedMyInfo = json.decode(response.body) as List<dynamic>;
    print(extractedMyInfo);
    for (int i = 0; i < extractedMyInfo.length; i++) {
      if (extractedMyInfo[i]['username'] == widget.username &&
          extractedMyInfo[i]['password'] == password) {
        lastValidatedPassword = password;
      }
    }
    lastRejectedPassword = password;

    _passwordKey.currentState!
        .validate(); // this will re-initiate the validation
  }

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _forgotPassword(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ForgotPasswordPage();
      }),
    );
  }

  void _goToTimeline(BuildContext ctx) {
    if (_passwordIsEntered) {
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
  }

  final _textFieldWidth = 330.0;
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
            const SizedBox(height: 30),
            const SizedBox(
              width: 320,
              child: Text(
                'Enter your password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  //color: _passwordIsValid ? Colors.blue : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: _textFieldWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: const TextStyle(
                      fontFamily: 'RalewayMedium',
                      fontSize: 16,
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1.3,
                    color: Colors.grey,
                  ),
                ],
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
                    if (value.isNotEmpty) {
                      setState(() {
                        _password = value;
                        _passwordIsEntered = true;
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.always,
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
            const SizedBox(height: 380),
            const Divider(
              height: 2,
              thickness: 0.9,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const SizedBox(width: 12),
                ElevatedButton(
                  child: const Text(
                    'Forgot Password?',
                  ),
                  onPressed: () {
                    _forgotPassword(context);
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder(
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 125),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {
                    setState(() {
                      if (_passwordKey.currentState!.validate()) {
                        _goToTimeline(context);
                      }
                    });
                  },
                  style: (!_passwordIsEntered)
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
