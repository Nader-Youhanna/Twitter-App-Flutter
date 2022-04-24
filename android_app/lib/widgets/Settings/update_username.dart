import 'package:flutter/material.dart';
import 'package:android_app/widgets/Settings/settings_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

class Update_username extends StatefulWidget {
  // const Update_username({Key? key}) : super(key: key);
  var _username;
  Update_username(this._username);
  @override
  State<Update_username> createState() => _Update_usernameState();
}

class _Update_usernameState extends State<Update_username> {
  //const Update_username({Key? key}) : super(key: key);
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  var _nameIsEntered = false;
  var _nameIsValid = false;

  bool _isNameValid(var name) {
    return (_nameIsValid = !RegExp(r"^nader$").hasMatch(name));
  }

  Future<void> httpRequestPost() async {
    var url = Uri.parse('http://$MY_IP_ADDRESS:3000/profile');
    var response =
        await http.post(url, body: {'username': '${widget._username}'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

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
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            leading: TextButton(
              child: Expanded(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
              onPressed: () {
                _goBack(context);
              },
            ),
            title: Text(
              "Update username",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      httpRequestPost();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    });
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Current",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget._username}",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //padding: EdgeInsets.only(top: 20),
                  children: <Widget>[
                    Text(
                      'New',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ]),
              const SizedBox(height: 20),
              SizedBox(
                width: 320,
                //mainAxisAlignment: MainAxisAlignment.start,
                child: Form(
                  child: SizedBox(
                    width: 320,
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (_nameIsValid && _nameIsEntered)
                            ? Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_nameIsEntered && !_nameIsValid)
                                ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nameIsEntered = value.isNotEmpty;
                          if (_nameKey.currentState!.validate()) {
                            widget._username = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value != null && _isNameValid(value)) {
                          return null;
                        } else {
                          return 'This username is already taken';
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
