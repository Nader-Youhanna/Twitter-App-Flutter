import 'package:flutter/material.dart';

import '../functions/http_functions.dart';
import '../constants.dart';
import './Tweets/tweet.dart';
import '../widgets/user_profile/profile.dart';
import './side_bar.dart';

class Timeline extends StatefulWidget {
  List<Tweet> tweets = <Tweet>[];

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final _appBarText = 'Search';

  late String _ipAddress;

  late String _port;

  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile("", 1, false);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    _setIPAddress(MY_IP_ADDRESS);
    return Scaffold(
      drawer: SideBar(name: 'nido', username: 'nido123'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () =>
                {_goToUserProfile(context)}), //button should open to side bar,
        actions: [
          Container(
            width: 260,
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintStyle: const TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 14.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: _appBarText,
              ),
            ),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
      body: Container(
        height: mediaQuery.size.height,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return widget.tweets[index];
          },
          itemCount: widget.tweets.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //add tweet
        onPressed: () => _startAddTweet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _setIPAddress(String ipAddressPort) {
    if (MY_IP_ADDRESS.indexOf(':') != -1) {
      _ipAddress = MY_IP_ADDRESS.substring(0, MY_IP_ADDRESS.indexOf(':'));
      _port = MY_IP_ADDRESS.substring(MY_IP_ADDRESS.indexOf(':') + 1);
    } else {
      _ipAddress = MY_IP_ADDRESS;
      _port = '3000';
    }
  }

  Future<void> _getTweets() async {
    print("Adding tweets");
    httpRequestGet("http://" + _ipAddress + ":" + _port + "/tweets/", null)
        .then((value) {
      setState(() {
        widget.tweets.clear();
        for (var i = 0; i < value.length; i++) {
          widget.tweets.add(Tweet.jsonTweet(value[i]));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _getTweets());
  }

  void _startAddTweet(BuildContext ctx) async {
    String tweetText = "";
    var tweetTextController = TextEditingController();
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Cancel'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    tweetText = tweetTextController.text;
                    print(tweetText);
                    var data = <String, dynamic>{
                      'userId': 1,
                      'createdAt': '2020-01-01T00:00:00.000Z',
                      'tweetText': tweetText,
                      'images': [],
                      'favouriters': [],
                      'retweeters': [],
                      'replies': [],
                    };
                    await _addTweet(data);
                    print("Tweet added");
                    await _getTweets();
                    print("Tweets retrieved");
                    Navigator.pop(ctx);
                  },
                  child: Text('Tweet'),
                ),
              ],
            ),
            //add tweet
            Container(
              padding: const EdgeInsets.all(10),
              //take input text from user
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintStyle: const TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 14.5,
                  ),
                  hintText: 'What\'s happening?',
                ),
                controller: tweetTextController,
              ),
            )
          ],
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      useRootNavigator: true,
    );
  }

  Future<void> _addTweet(Map<String, dynamic> data) async {
    return await httpRequestPost(
        "http://" + _ipAddress + ":" + _port + "/tweets/", data);
  }
}
