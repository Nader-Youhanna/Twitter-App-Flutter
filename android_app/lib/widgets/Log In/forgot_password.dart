import 'package:android_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var _username;

  var _usernameIsEntered = false;
  var _searchButtonClicked = false;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<void> _searchForPassword(String username) async {
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/forgot-password');
    var response = await http.post(
      url,
      body: {
        'email': _username,
      },
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
                'Find your Sirius account',
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
                  hintText: 'Enter your email',
                ),
                onChanged: (value) {
                  setState(() {
                    _usernameIsEntered = value.isNotEmpty;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    _username = value;
                    _usernameIsEntered = value.isNotEmpty;
                  });
                },
              ),
            ),
            !_searchButtonClicked
                ? const SizedBox(height: 470)
                : VerificationCodeMessage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _searchButtonClicked = true;
                      _searchForPassword(_username);
                    });
                  },
                  child: const Text('Search'),
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
                SizedBox(width: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationCodeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        const Text(
          '''We have sent a confirmation
        code to your email''',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'RalewayMedium',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: null,
          child: const Text('Resend email'),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<StadiumBorder>(
              const StadiumBorder(),
            ),
          ),
        ),
        const SizedBox(height: 390),
      ],
    );
  }
}
