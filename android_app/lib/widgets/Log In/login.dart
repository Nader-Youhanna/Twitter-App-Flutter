import 'package:flutter/material.dart';
import './enter_password.dart';
import 'forgot_password.dart';
import 'package:flutter/foundation.dart';

///This is the login page
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _usernameIsEntered = false;
  String _username = '';
  bool isAndroid = true;

  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  ///This is a navigation function that redirects to the enter password page
  void _enterPassword(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return EnterPasswordPage(email: _username);
      }),
    );
  }

  ///This is a navigation function that redirects to the forgot password page
  void _forgotPassword(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ForgotPasswordPage();
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
            //const SizedBox(height: 35),
            SizedBox(
                height: MediaQuery.of(context).size.height * (35 / 740.6666)),
            Row(
              children: <Widget>[
                //const SizedBox(width: 12),
                SizedBox(
                    width: isAndroid
                        ? MediaQuery.of(context).size.width * (12 / 360.0)
                        : MediaQuery.of(context).size.width * (5 / 360.0)),
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
                //const SizedBox(width: 70),
                SizedBox(
                    width: isAndroid
                        ? MediaQuery.of(context).size.width * (70 / 360.0)
                        : MediaQuery.of(context).size.width * (150 / 360.0)),
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
                'To get started, first enter your email',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 330,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _username = value;
                    setState(() {
                      _usernameIsEntered = true;
                    });
                  }
                },
              ),
            ),
            //const SizedBox(height: 435),
            SizedBox(
                height: isAndroid
                    ? MediaQuery.of(context).size.height * (435 / 740.6666)
                    : MediaQuery.of(context).size.height * (570 / 1000)),
            const Divider(
              height: 2,
              thickness: 0.9,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                //const SizedBox(width: 12),
                SizedBox(
                    width: isAndroid
                        ? MediaQuery.of(context).size.width * (12 / 360)
                        : MediaQuery.of(context).size.width * (250 / 1000)),
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
                //const SizedBox(width: 125),
                SizedBox(
                  width: isAndroid
                      ? MediaQuery.of(context).size.width * (125 / 360)
                      : MediaQuery.of(context).size.width * (200 / 1000),
                ),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {
                    _enterPassword(context);
                  },
                  style: (!_usernameIsEntered)
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
