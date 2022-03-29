import 'package:flutter/material.dart';

class User {
  final username;
  final password;
  final email;
  final phone;
  bool loggedIn = false;
  User({@required this.username, this.email, this.password, this.phone}) {}
}
