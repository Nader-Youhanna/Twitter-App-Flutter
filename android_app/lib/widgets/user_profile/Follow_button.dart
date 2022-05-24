import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

///class that creates the follow/unfollow button and changes it state based of following or not
class Follow_button extends StatefulWidget {
  String _username;
  bool _alreadyfollowed;
  String token;

  Follow_button(this._alreadyfollowed, this._username, this.token);

  @override
  State<Follow_button> createState() => _Follow_buttonState();
}

class _Follow_buttonState extends State<Follow_button> {
  String Status = "0";

  ///function to send follow request to server
  Future<void> Follow_user() async {
    var data;
    print("following user");
    var url =
        Uri.parse("http://34.236.108.123:3000/${widget._username}/follow");
    try {
      var response = await http.post(
        url,
        body: jsonEncode({}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            Status = data['status'] as String;
          });
        }
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  ///function to send delete request (to unfollow users) to the server
  Future<void> UnFollow_user() async {
    var data;
    print("following user");
    var url =
        Uri.parse("http://34.236.108.123:3000/${widget._username}/unfollow");
    try {
      var response = await http.delete(
        url,
        body: jsonEncode({}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + widget.token
        },
      );
      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            Status = data['status'] as String;
          });
        }
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget._alreadyfollowed ? Colors.white : Colors.black,
        shape: StadiumBorder(),
        shadowColor: Colors.black,
        side: BorderSide(width: 1, color: Color.fromARGB(255, 68, 68, 68)),
        minimumSize: Size(100, 30),
      ),
      child: Text(
        (widget._alreadyfollowed ? 'unFollow' : 'Follow'),
        style: TextStyle(
          fontSize: 14,
          color: widget._alreadyfollowed ? Colors.black : Colors.white,
        ),
      ),
      onPressed: () {
        if (widget._alreadyfollowed) {
          setState(() {
            UnFollow_user();
          });
        } else {
          setState(() {
            Follow_user();
          });
        }
        setState(() {
          widget._alreadyfollowed = !widget._alreadyfollowed;
        });
      },
    );
  }
}
