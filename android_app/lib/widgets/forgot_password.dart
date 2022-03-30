import 'package:flutter/material.dart';

class ForgorPasswordPage extends StatefulWidget {
  @override
  State<ForgorPasswordPage> createState() => _ForgorPasswordPageState();
}

class _ForgorPasswordPageState extends State<ForgorPasswordPage> {
  var _username;

  var _usernameIsEntered = false;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
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
                  hintText: 'Enter your email, phone number or username',
                ),
                onSubmitted: (value) {
                  setState(() {
                    _username = value;
                    _usernameIsEntered = true;
                  });
                },
              ),
            ),
            const SizedBox(height: 400),
            Row(
              children: <Widget>[
                const SizedBox(width: 12),
                const SizedBox(width: 125),
                ElevatedButton(
                  onPressed: null,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
