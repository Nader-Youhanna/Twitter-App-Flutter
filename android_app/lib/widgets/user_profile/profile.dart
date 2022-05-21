import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/LikesTab.dart';
import 'package:android_app/widgets/user_profile/TweetsandrepliesTab.dart';
import 'package:android_app/widgets/user_profile/Tweetstab.dart';
import 'package:android_app/widgets/user_profile/mediaTab.dart';

import 'package:android_app/widgets/user_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';

///class that creates a single choice item in a pop up menu
class Choice {
  const Choice(
      {required this.title, required this.icon, this.isEnable = false});
  final bool isEnable;
  final IconData icon;
  final String title;
}

/// a list of choices included in a pop up menue
const List<Choice> choices = <Choice>[
  Choice(
    title: 'Share',
    icon: Icons.directions_car,
  ),
  Choice(title: 'Block', icon: Icons.directions_bike),
  Choice(title: 'Mute', icon: Icons.directions_bike),
  Choice(title: 'Report', icon: Icons.directions_bike),
];

///class that creates user profile page, whether this user is myself or another user
class Profile extends StatefulWidget {
  String _username = 'Defaultuser';
//int userId = 0;
  bool isAdmin = false;

  Profile(this._username, this.isAdmin);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String username = 'username';
  late String name = "";
  late bool protectedTweets = true;
  late String city = "";
  late String country = "";
  late String bio = "bio";
  late DateTime birthdate = DateTime.parse("2001-09-12T00:00:00.000Z");
  late DateTime createdAt = DateTime.parse("2022-04-25T02:26:31.367Z");
  late var _followersCount = 0;
  late var _followingCount = 0;
  late var _myProfile;
  late bool _alreadyFollowed = false;
  late String website = "";
  late var selectedItem = "";
  late bool followsme = false;
  late List<dynamic> userTweets = [];
  late List<dynamic> followersList = [];
  late List<dynamic> followingList = [];
  late final Future? myFuture;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  ///function that sends a get request to the mock server to get the user's information
  Future<void> getuserData() async {
    var data;
    print("getting user data");
    var url = Uri.parse("http://192.168.1.8:3000/${widget._username}");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("${response.body}");
        if (data != null) {
          setState(() {
            username = data['username'] as String;
            _myProfile = data['isMe'] as bool;
            name = data['name'] as String;
            birthdate = DateTime.parse(data['birthdate'] as String);
            userTweets = data['tweets'] as List<dynamic>;
            protectedTweets = data['protectedTweets'] as bool;
            _followingCount = data['followingCount'] as int;
            _followersCount = data['followersCount'] as int;

            if (_myProfile == false) {
              followsme = data['followsMe'] as bool;
            } else {
              createdAt = DateTime.parse(data['createdAt'] as String);
              country = data['country'] as String;
              city = data['city'] as String;
              bio = data['bio'] as String;
              website = data['website'] as String;
            }
          });
        }
      } else {
        print('fetch error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }

  ///function to create a sharable link of the current profile
  void _ShareProfile() {
    print("share working");
    Share.share("/profile/${widget._username}");
  }

  bool isAndroid = true;
  @override
  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
    super.initState();
    myFuture = getuserData();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    //String dropdownValue = 'One';
    var _tabs = ["Tweets", "Tweets & replies", "Media", "Likes"];

    return FutureBuilder(
      future: myFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return MaterialApp(
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white, centerTitle: true),
                  tabBarTheme: TabBarTheme(labelColor: Colors.black)),
              home: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: AppBar(
                    leading: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        _goBack(context);
                      },
                    ),
                    //IconButton
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.search),
                          tooltip: 'search Icon',
                          onPressed: () {},
                          color: Colors.white),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return choices.map((Choice choice) {
                            return PopupMenuItem<Choice>(
                              value: choice,
                              child: Text(choice.title),
                            );
                          }).toList();
                        },
                        onSelected: (value) {
                          _ShareProfile;
                        },
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/cover_image_sample.jpg',
                            fit: BoxFit.cover,
                          ),
                          const DecoratedBox(
                              decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 0.5),
                              end: Alignment.center,
                              colors: <Color>[
                                Color(0x60000000),
                                Color(0x00000000),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                body: DefaultTabController(
                  length: _tabs.length,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: SliverAppBar(
                            //title: const Text('Books'),
                            pinned: true,
                            floating: false,
                            expandedHeight: 220.0,
                            stretch: true,
                            onStretchTrigger: () {
                              return Future<void>.value();
                            },
                            forceElevated: innerBoxIsScrolled,
                            bottom: TabBar(
                              tabs: _tabs
                                  .map((String name) => Tab(text: name))
                                  .toList(),
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.only(
                                            left: 15, right: 32),
                                        child: new CircleAvatar(
                                          backgroundImage: new AssetImage(
                                              'assets/images/user_icon.png'),
                                          radius: 35,
                                          backgroundColor: Colors.grey,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: _myProfile
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.white,
                                                        shape: StadiumBorder(),
                                                        shadowColor:
                                                            Colors.black,
                                                        side: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    68,
                                                                    68,
                                                                    68)),
                                                        minimumSize:
                                                            Size(100, 30),
                                                      ),
                                                      child: Text(
                                                        'Edit Profile',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Edit_Profile(
                                                                        widget
                                                                            ._username)));
                                                      },
                                                    )
                                                  : Follow_button(
                                                      _alreadyFollowed),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 0),
                                      padding:
                                          EdgeInsets.only(left: 15, right: 32),
                                      child: Text(
                                        widget._username,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'PlayfairDisplay',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      padding:
                                          EdgeInsets.only(left: 15, right: 32),
                                      child: Text(
                                        bio,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      )),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 0.0, bottom: 10),
                                        padding:
                                            EdgeInsets.only(left: 10, right: 5),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Accounts_page(widget
                                                              ._username)));
                                            },
                                            child: Text(
                                              '${_followersCount} followers',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 185, 182, 182),
                                                fontSize: 12.0,
                                              ),
                                            )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 0.0, bottom: 10),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 32),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Accounts_page(widget
                                                              ._username)));
                                            },
                                            child: Text(
                                              '${_followingCount} following',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 185, 182, 182),
                                                fontSize: 12.0,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: (!_myProfile && protectedTweets && !followsme)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(40),
                                    child: Column(
                                      children: <Widget>[
                                        Text("These Tweets are protected.",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Only confirmed followers have access to ${widget._username}'s tweets and complete profile. Tap the Follow button to send a follow request.")
                                      ],
                                    ))
                              ])
                        : TabBarView(
                            children: [
                              TweetTab(username, username),
                              TweetsAndReplies(username, username),
                              MediaTab(username, username),
                              LikesTab(username, username),
                            ],
                          ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
