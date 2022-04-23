import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    print('Ok2');
    final googleUser = await googleSignIn.signIn();

    print('Ok3');
    _user = googleUser;
    final googleAuth = await googleUser!.authentication;
    print('Ok4');
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('Ok5');

    await FirebaseAuth.instance.signInWithCredential(credential);
    print('Ok6');
    notifyListeners();
  }
}
