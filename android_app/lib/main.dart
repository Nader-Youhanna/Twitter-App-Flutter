import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import './widgets/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/google_sign_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp();
    print('Running on Android');
  } else {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
        apiKey: "XXX",
        appId: "XXX",
        messagingSenderId: "XXX",
        projectId: "XXX",
      ),
    );
    print("Running on Browser");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: StartPage(),
        ),
      ),
    ));
  }
}
