import 'package:android_app/widgets/Push%20Notifications/push_notifications.dart';
import 'package:android_app/widgets/Settings/ConfirmPassDeactivate.dart';
import 'package:android_app/widgets/Settings/Deactivate_account.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
    return OverlaySupport(
        child: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: Settings(),
        ),
      ),
    ));
  }
}
