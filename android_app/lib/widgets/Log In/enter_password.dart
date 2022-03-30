import 'package:flutter/material.dart';

class EnterPasswordPage extends StatefulWidget {
  final username;

  EnterPasswordPage({@required this.username});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  final _textFieldWidth = 330.0;

  var _password;
  var _passwordIsEntered = false;
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
                'Enter your password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
              child: TextField(
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
                onSubmitted: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      _passwordIsEntered = true;
                      _password = value;
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 400),
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
                  onPressed: () {},
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
                  onPressed: null,
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
