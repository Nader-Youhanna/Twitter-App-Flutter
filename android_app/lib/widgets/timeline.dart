import 'package:flutter/material.dart';

import '../functions/tweet_functions.dart';
import '../constants.dart';
import './Tweets/tweet.dart';
import '../widgets/user_profile/profile.dart';
import './side_bar.dart';
import './Settings/settings_main.dart';

/// This class is used to represent the timeline page.
class Timeline extends StatefulWidget {
  List<Tweet> tweets = <Tweet>[];

  String _name = "";
  String _userName = "";

  Timeline(this._name, this._userName);
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _appBarText = 'Search';
  late String _ipAddress;

  late String _port;

  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Profile("", 1, false);
        },
      ),
    );
  }

  void _goToSettings(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Settings();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    _setIPAddress(MY_IP_ADDRESS);
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(name: 'nido', username: 'nido123'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
          icon: const Icon(
              Icons.person_rounded), //should be changed to google profile icon
          color: Colors.black,
          onPressed: () {
            // _goToUserProfile(context);
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
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
            onPressed: () {
              _goToSettings(context);
            },
          ), //button shoud direct to setings
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
        onPressed: () => startAddTweet(context, _ipAddress, _port),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _setIPAddress(String ipAddressPort) {
    if (MY_IP_ADDRESS.contains(':')) {
      _ipAddress = MY_IP_ADDRESS.substring(0, MY_IP_ADDRESS.indexOf(':'));
      _port = MY_IP_ADDRESS.substring(MY_IP_ADDRESS.indexOf(':') + 1);
    } else {
      _ipAddress = MY_IP_ADDRESS;
      _port = '3000';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      List<Tweet> serverTweets = await getTweets(_ipAddress, _port);
      setState(() {
        widget.tweets = serverTweets;
      });
    });
  }
}
