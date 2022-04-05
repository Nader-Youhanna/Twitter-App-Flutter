import 'package:flutter/material.dart';
import 'Sign Up/sign_up.dart';
import 'Log In/login.dart';

class StartPage extends StatelessWidget {
  void goToSignUpPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return SignUp();
      }),
    );
  }

  void goToLoginPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Login();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 35),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/images/logo_icon.png',
                width: 120,
                height: 50,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 175,
            ),
            const SizedBox(
              width: 290,
              child: Text(
                'See what\'s happening in the world right now.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 35,
              width: 265,
              child: ElevatedButton(
                child: const Text(
                  'Create Account',
                ),
                onPressed: () {
                  goToSignUpPage(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
              ),
            ),
            const SizedBox(height: 45),
            //Google and Facebook
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(width: 80),
                  Image.asset(
                    'assets/images/google_logo.png',
                    width: 25,
                    //height: 70,
                    //fit: BoxFit.fill,
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign Up with Google'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(width: 80),
                  const Icon(Icons.facebook, size: 26),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign Up with Facebook'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Have an account already?',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    goToLoginPage(context);
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
