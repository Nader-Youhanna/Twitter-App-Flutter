import 'dart:io' show Platform;
import 'package:android_app/constants.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:android_app/widgets/user_profile/FollowRequests.dart';
import 'package:android_app/widgets/user_profile/edit_profile.dart';
import 'package:android_app/widgets/user_profile/profile.dart';
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
            body: FollowRequests('user2',
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyOGQyYjk3M2NjNmIzNmVlN2ZlOTQzYyIsImlhdCI6MTY1MzQxOTczNiwiZXhwIjoxNjYyMDU5NzM2fQ.MbeJmBmnkBivIhqgBD3U4_lH4k8twxFh-45cAASS6I4"),
          ),
        ),
      ),
    );
  }
}
