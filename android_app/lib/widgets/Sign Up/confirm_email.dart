import 'package:flutter/material.dart';
import './terms_and_conditions.dart';

class ConfirmEmail extends StatelessWidget {
  var username;
  var email;
  var dob;
  var name;

  ConfirmEmail({
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.dob,
  });

  void _goToTermsAndConditions(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return TermsAndConditions(
          name: name,
          username: username,
          email: email,
          dob: dob,
        );
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
                  onPressed: () {},
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
            const SizedBox(height: 100),
            const Text('A confirmation link has been sent to your email.'),
            const SizedBox(height: 200),
            ElevatedButton(
              child: const Text('I have confirmed my email'),
              onPressed: () {
                _goToTermsAndConditions(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
