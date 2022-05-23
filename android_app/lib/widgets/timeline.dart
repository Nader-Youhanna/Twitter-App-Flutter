import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../functions/tweet_functions.dart';
import '../constants.dart';
import './Tweets/tweet.dart';
import '../widgets/user_profile/profile.dart';
import './side_bar.dart';
import './Settings/settings_main.dart';
import 'Explore/search_bar_explore.dart';
import 'Search/timeline_delegate.dart';

/// This class is used to represent the timeline page.
class Timeline extends StatefulWidget {
  List<Tweet> tweets = <Tweet>[];

  String name = "";
  String userName = "";
  String userImage = '';
  bool isAdmin = false;
  String email = '';
  String token;

  Timeline(
      {required this.name,
      required this.userName,
      required this.userImage,
      required this.isAdmin,
      required this.email,
      required this.token});
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
          return Profile("", false, widget.token);
        },
      ),
    );
  }

  void _goToSettings(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Settings(widget.token, widget.userName, "");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    //_setIPAddress(MY_IP_ADDRESS);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(
        name: widget.name,
        username: widget.userName,
        userImage: widget.userImage,
        isAdmin: widget.isAdmin,
        email: widget.email,
        token: widget.token,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
            width: isAndroid ? width * (290 / 392.7) : width * (1190 / 1280),
            padding: const EdgeInsets.all(10),
            child: TextField(
                showCursor: false,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: Color.fromARGB(255, 229, 233, 235),
                  hintStyle: const TextStyle(
                    fontSize: 14.5,
                    color: Color.fromARGB(255, 100, 99, 99),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: _appBarText,
                ),
                // onTap: () {
                //   //redirects us to the page with the searching elements
                //   showSearch(
                //       context: context,
                //       delegate: MySearchDelegate(' '));
                // }
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: TimelineSearchDelegate(),
                  );
                }),
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
        child: RefreshIndicator(
          onRefresh: () => _refresh(),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return widget.tweets[index];
            },
            itemCount: widget.tweets.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //add tweet
        onPressed: () => startAddTweet(context),
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

  bool isAndroid = true;
  @override
  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Tweet> serverTweets = await getTweets();
      setState(() {
        widget.tweets = serverTweets;
      });
    });
  }

  Future<void> _refresh() async {
    List<Tweet> serverTweets = await getTweets();
    setState(() {
      widget.tweets = serverTweets;
    });
  }
}
