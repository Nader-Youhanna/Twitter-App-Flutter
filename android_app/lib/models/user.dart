import 'package:flutter/material.dart';

class User {
  final String uid;
  final List following;
  final List followers;
  final String username;
  final String photoUrl;
  final String bio;
  final password;
  final email;
  final phone;
  bool loggedIn = false;
  User({
    required this.username,
    this.email,
    this.password,
    this.phone,
    required this.uid,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "emial": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        "password": password,
        "phone": phone,
      };
}
