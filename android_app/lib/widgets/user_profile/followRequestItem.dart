import 'package:android_app/widgets/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
//import './tweetsOnly.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestsItem extends StatelessWidget {
  //const RequestsItem({Key? key}) : super(key: key);
  String username = "username";
  String handle = "@username";
  String id = "";
  late String token;
  CircleAvatar userImage = CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 25.0,
  );

  ///constuctor to map Json data fetched from the server to the specified class members
  RequestsItem.jsonFollowRequest(
      Map<String, dynamic> JsonUserItem, String getToken) {
    username = JsonUserItem['name'] as String;
    handle = JsonUserItem['username'] as String;
    id = JsonUserItem['_id'] as String;
    if (JsonUserItem['image'] != null) {
      userImage = CircleAvatar(
        backgroundImage: NetworkImage(JsonUserItem['image'] as String),
        radius: 25.0,
      );
    }
    token = getToken;
  }

  ///function to send accept follow request to the server
  Future<void> acceptFollow() async {
    var data;
    print("accepting request");
    var url =
        Uri.parse("http://34.236.108.123:3000/home/Follow-requests/accept");
    try {
      var response = await http.post(
        url,
        body: jsonEncode({
          'username': username,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  ///function to send reject follow request to the server
  Future<void> RejectRequest() async {
    var data;
    print("rejecting request");
    var url =
        Uri.parse("http://34.236.108.123:3000/home/Follow-requests/reject");
    try {
      var response = await http.delete(
        url,
        body: jsonEncode({
          "id": id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      print("${response.statusCode}");
      print("${response.body}");

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(handle, false, token)));
              },
              child: userImage,
            ),
            title: Text(
              username,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "${username} " + "${handle}",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      acceptFollow();
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      RejectRequest();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
