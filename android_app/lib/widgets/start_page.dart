import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Sign Up/sign_up.dart';
import 'Log In/login.dart';
import '../providers/google_sign_in.dart';
import './bottom_nav_bar.dart';
import 'package:flutter/foundation.dart';

///This is a navigation function that redirects to login page
void goToSignUpPage(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return SignUp();
      },
    ),
  );
}

///This is a navigation function that redirects to login page
void goToLoginPage(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return Login();
      },
    ),
  );
}

///This is the first Page that gets loaded
class StartPage extends StatelessWidget {
  bool isAndroid = true;

  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            return MyNavigationBar(
              name: user!.displayName!,
              username: user.displayName!,
              token: '',
              isAdmin: false,
              email: '',
              userImage: '',
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went Wrong!'));
          } else {
            return SignUpWidget();
          }
        },
      ),
    );
  }
}

///This is the Sign Up part of the start page
class SignUpWidget extends StatefulWidget {
  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool isAndroid = true;

  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //New logo
          //const SizedBox(height: 55),
          SizedBox(
              height: MediaQuery.of(context).size.height * (55 / 740.6666)),
          const Text(
            'Sirius',
            style: TextStyle(
              fontSize: 38,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontFamily: 'RalewayMedium',
            ),
          ),
          //const SizedBox(height: 140),
          SizedBox(
            height: isAndroid
                ? MediaQuery.of(context).size.height * (140 / 740.6666)
                : MediaQuery.of(context).size.height * (120 / 740.6666),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * (290 / 360),
            child: const Text(
              'See what\'s happening in the world right now.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //const SizedBox(height: 40),
          SizedBox(height: MediaQuery.of(context).size.height * (40 / 740.666)),
          SizedBox(
            // height: 35,
            // width: 265,
            height: MediaQuery.of(context).size.height * (35 / 740.666),
            width: isAndroid
                ? MediaQuery.of(context).size.width * (265 / 360)
                : MediaQuery.of(context).size.width * 0.12,
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
          //const SizedBox(height: 45),
          SizedBox(
            height: isAndroid
                ? MediaQuery.of(context).size.height * (45 / 740.666666)
                : MediaQuery.of(context).size.height * (60 / 740.666666),
          ),
          //Google and Facebook
          SizedBox(
            //height: 40,
            height: MediaQuery.of(context).size.height * (40 / 740.666666),
            child: Row(
              children: [
                //const SizedBox(width: 80),
                SizedBox(
                  width: isAndroid
                      ? MediaQuery.of(context).size.width * (80 / 360)
                      : MediaQuery.of(context).size.width * 0.43,
                ),
                SizedBox(
                  //width: 205,
                  width: isAndroid
                      ? MediaQuery.of(context).size.width * (205 / 360)
                      : MediaQuery.of(context).size.width * 0.145,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Ok');
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
                    label: const Text('Sign In with Google'),
                  ),
                ),
              ],
            ),
          ),
          //const SizedBox(height: 20),
          SizedBox(
              height: isAndroid
                  ? MediaQuery.of(context).size.height * (20 / 740.666666)
                  : MediaQuery.of(context).size.height * (20 / 740)),
          SizedBox(
            //height: 40,
            height: isAndroid
                ? MediaQuery.of(context).size.height * (40 / 740.666666)
                : MediaQuery.of(context).size.height * 0.06,
            child: Row(
              children: [
                //const SizedBox(width: 80),
                SizedBox(
                  width: isAndroid
                      ? MediaQuery.of(context).size.width * (80 / 360)
                      : MediaQuery.of(context).size.width * 0.43,
                ),
                SizedBox(
                  //width: 210,
                  width: isAndroid
                      ? MediaQuery.of(context).size.width * (210 / 360)
                      : MediaQuery.of(context).size.width * 0.145,
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
                    label: const Text('Sign In with Facebook'),
                  ),
                ),
              ],
            ),
          ),
          //const SizedBox(height: 150),
          SizedBox(
              height: MediaQuery.of(context).size.height * (150 / 740.6666)),
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
    );
  }
}
