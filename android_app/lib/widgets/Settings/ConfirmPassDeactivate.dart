import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:flutter/gestures.dart';

class ConfirmforDeactivate extends StatefulWidget {
  const ConfirmforDeactivate({Key? key}) : super(key: key);

  @override
  State<ConfirmforDeactivate> createState() => _ConfirmforDeactivateState();
}

class _ConfirmforDeactivateState extends State<ConfirmforDeactivate> {
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
            title: Text(
              'Sirius',
              style: TextStyle(
                fontSize: 38,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: 'RalewayMedium',
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Confirm your password",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RalewayMedium',
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: Text(
                  'Complete your deactivation request by entering the password associated with your account.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
