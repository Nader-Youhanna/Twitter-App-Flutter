import 'package:flutter/material.dart';
import './choose_password.dart';

class TermsAndConditions extends StatelessWidget {
  final username, email, dob;
  static const _widthOfTextFields = 280.0;
  static const _textFieldsFontSize = 18.0;

  static const termsText = '''
      By signing up, you agree to the Terms
      of Service and Privacy Policy, including
      Cookie Use Sirius may use your contact
      information, including your email address
      and phone number for purposes outlined in
      our Privacy Policy, like keeping your account
      secure and personalizing our services,
      including ads. Learn more. Others will be able
      to find you by email or phone number,when
      provided, unless you choose otherwise here.
      ''';

  TermsAndConditions(
      {@required this.username, @required this.email, @required this.dob});

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _goToChoosePassword(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ChoosePassword();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              'Create your account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: TermsAndConditions._widthOfTextFields,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 17),
                Row(
                  children: <Widget>[
                    Text(
                      username,
                      style: const TextStyle(
                        fontFamily: 'RalewayMedium',
                        fontSize: TermsAndConditions._textFieldsFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Divider(
                  height: 1,
                  thickness: 1.4,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Text(
                      email,
                      style: const TextStyle(
                        fontFamily: 'RalewayMedium',
                        fontSize: TermsAndConditions._textFieldsFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Divider(
                  height: 1,
                  thickness: 1.4,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Text(
                      dob,
                      style: const TextStyle(
                        fontFamily: 'RalewayMedium',
                        fontSize: TermsAndConditions._textFieldsFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Divider(
                  height: 1,
                  thickness: 1.4,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          const SizedBox(
            child: Text(
              TermsAndConditions.termsText,
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontSize: 14.2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: 265,
            child: ElevatedButton(
              child: const Text(
                'Sign Up',
              ),
              onPressed: () {
                _goToChoosePassword(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
