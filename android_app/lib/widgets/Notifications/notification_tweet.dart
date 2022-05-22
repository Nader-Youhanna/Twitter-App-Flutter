import 'package:flutter/material.dart';
import '../Tweets/tweet.dart';
import '../../constants.dart';
import '../../functions/http_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///Class that holds the page that displays the tweet with whivh the notification is concerned
class NotificationTweet extends StatefulWidget {
  String tweetID;
  @override
  State<NotificationTweet> createState() => NotificationTweetState();
  NotificationTweet(this.tweetID);
}

class NotificationTweetState extends State<NotificationTweet> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<List<Tweet>> getNotificationTweet() async {
    List<Tweet> tweet = <Tweet>[]; //should only contain one element
    String tweetID = widget.tweetID;
    print("Adding notification tweet");
    //var url = Uri.parse("http://$MY_IP_ADDRESS:3000/getTweetById");//url used for mock server
    var url = Uri.parse(
        "http://$MY_IP_ADDRESS:3000/home/$tweetID/getTweetById"); //url used for mock server and backend
    Map<String, dynamic> headers = {
      "Authorization": "Bearer " + constToken,
      "Content-Type": "application/json"
    };
    var request = http.Request('GET', url);
    if (headers != null) {
      request.headers['Content-Type'] = headers['Content-Type'];
      request.headers['Authorization'] = headers['Authorization'];
    }
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    var mapData = json.decode(response.body);

    tweet.add(Tweet.jsonTweetByID(mapData['tweetData'], false, true));

    return tweet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: const Text(
            "Tweet",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              //Icons.abc,
              color: Colors.black,
            ),
            onPressed: () {
              _goBack(context);
            },
          )),
      body: FutureBuilder<List<Tweet>>(
          future: getNotificationTweet(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.data == null) {
                  return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(height: 100),
                        Center(child: CircularProgressIndicator()),
                        SizedBox(height: 50),
                        Center(
                          child: Text('Server error..please wait'),
                        )
                      ]);
                } else {
                  List<Tweet> data = snapshot.data!;
                  return data[0];
                }
            }
          }),
    );
  }
}
