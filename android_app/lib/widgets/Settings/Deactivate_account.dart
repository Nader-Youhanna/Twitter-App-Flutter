import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/gestures.dart';
import 'package:android_app/widgets/Settings/ConfirmPassDeactivate.dart';

class Deactivate extends StatefulWidget {
  //const Deactivate({Key? key}) : super(key: key);
  String name;
  String username;
  bool isPrivate;
  String email; //needed to pass for covfirm deactivate and nav to settings
  //String password;
  String token;
  Deactivate(this.name, this.username, this.isPrivate, this.token, this.email);
  @override
  State<Deactivate> createState() => _DeactivateState();
}

class _DeactivateState extends State<Deactivate> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Deactivate your account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: "@${widget.username}",
                    style: TextStyle(
                        color: Color.fromARGB(255, 62, 62, 62), fontSize: 14),
                  ),
                ],
              ),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                _goBack(context);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  '${widget.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RalewayMedium',
                  ),
                ),
                subtitle: Text(
                  "${widget.username}",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 62, 62, 62)),
                ),
                leading: new CircleAvatar(
                  backgroundImage:
                      new AssetImage('assets/images/user_icon.png'),
                  radius: 20,
                  backgroundColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                child: Text(
                  'This will deactivate your account',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RalewayMedium',
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 320,
                child: Text(
                  "You're about to start the process of deactivating your Sirius account, Your display name, @username, and public profile will no longer be viewable on Sirius.com, Sirius for iOS, or Sirius for Android.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 320,
                child: Text(
                  'What else you should know',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RalewayMedium',
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                child: Text(
                  "You can restore your Sirius account if it was accidentally or wrongfully deactivated for up to 30 days after deactivation.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 320,
                child: Text(
                  "Some account information may still be available in search engines, such as Google or Bing.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 320,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'RalewayMedium',
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'If you just want to change your @username, you dont need to deactivate your account--edit it in your '),
                      TextSpan(
                        text: "settings.",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings(widget.token,
                                        widget.username, widget.email)));
                          },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      child: Text(
                        "Deactivate",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmforDeactivate(
                                    widget.token,
                                    widget.username,
                                    widget.email)));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
