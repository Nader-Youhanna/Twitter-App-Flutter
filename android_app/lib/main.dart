import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:android_app/widgets/Settings/update_email.dart';
import 'package:android_app/widgets/Settings/verify_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './widgets/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/google_sign_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: Settings(),
        ),
      ),
    );
  }
}
