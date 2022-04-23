import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Sign Up/sign_up.dart';
import 'Log In/login.dart';
import '../providers/google_sign_in.dart';

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
            //New logo
            const SizedBox(height: 55),
            const Text(
              'Sirius',
              style: TextStyle(
                fontSize: 38,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: 'RalewayMedium',
              ),
            ),
            const SizedBox(
              height: 140,
            ),

            //Old logo
            // const SizedBox(
            //   height: 35,
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
            // const SizedBox(
            //   height: 175,
            // ),
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
                  SizedBox(
                    width: 205,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.grey.shade700,
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      label: const Text('Sign Up with Google'),
                    ),
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
                  SizedBox(
                    width: 210,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff3c5c9c),
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      icon: const Icon(
                        Icons.facebook,
                        size: 29,
                      ),
                      onPressed: () {},
                      label: const Text('Sign Up with Facebook'),
                    ),
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
