import 'package:android_app/widgets/user_profile/Follow_button.dart';
import 'package:android_app/widgets/user_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:android_app/widgets/timeline.dart';
import 'package:android_app/widgets/user_profile/Show_followers_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import '../../constants.dart';

class Choice {
  const Choice(
      {required this.title, required this.icon, this.isEnable = false});
  final bool isEnable;
  final IconData icon;
  final String title;
}

const List<Choice> choices = <Choice>[
  Choice(
    title: 'Share',
    icon: Icons.directions_car,
  ),
  Choice(title: 'Block', icon: Icons.directions_bike),
  Choice(title: 'Mute', icon: Icons.directions_bike),
  Choice(title: 'Report', icon: Icons.directions_bike),
];

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = 'username';
  var _followersCount = 0;
  var _followingCount = 0;
  String bio = "bio";
  String uid = "";
  var selectedItem = "";
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<void> httpRequestGet() async {
    var url = Uri.parse('http://${MY_IP_ADDRESS}:3000/profile');
    var response = await http.get(url);

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      username = extractedMyInfo["username"];
      bio = extractedMyInfo["bio"];
      _followersCount = extractedMyInfo["followers"].length;
      _followingCount = extractedMyInfo["following"].length;
    });
  }

  void _ShareProfile() {
    print("share working");
    Share.share("/profile/${uid}");
  }

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      httpRequestGet();
    });
  }

  Widget build(BuildContext context) {
    //String dropdownValue = 'One';
    var _tabs = ["Tweets", "Tweets & replies", "Media", "Likes"];
    bool _myProfile = true;
    bool _alreadyFollowed = false;

    List<Tweet> tweets = [
      //Tweet.jsonTweet(),
    ];

    return MaterialApp(
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.white, centerTitle: true),
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
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                      tabs:
                          _tabs.map((String name) => Tab(text: name)).toList(),
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
                                padding: EdgeInsets.only(left: 15, right: 32),
                                child: new CircleAvatar(
                                  backgroundImage: new AssetImage(
                                      'assets/images/user_icon.png'),
                                  radius: 35,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: _myProfile
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                shape: StadiumBorder(),
                                                shadowColor: Colors.black,
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 68, 68, 68)),
                                                minimumSize: Size(100, 30),
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
                                                            const Edit_Profile()));
                                              },
                                            )
                                          : Follow_button(_alreadyFollowed),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 0),
                              padding: EdgeInsets.only(left: 15, right: 32),
                              child: Text(
                                username,
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
                              padding: EdgeInsets.only(left: 15, right: 32),
                              child: Text(
                                bio,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              )),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 0.0, bottom: 10),
                                padding: EdgeInsets.only(left: 10, right: 5),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Accounts_page()));
                                    },
                                    child: Text(
                                      '${_followersCount} followers',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 185, 182, 182),
                                        fontSize: 12.0,
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0.0, bottom: 10),
                                padding: EdgeInsets.only(left: 10, right: 32),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Accounts_page()));
                                    },
                                    child: Text(
                                      '${_followingCount} following',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 185, 182, 182),
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
            body: TabBarView(
              children: [
                Timeline(tweets),
                Timeline(tweets),
                Timeline(tweets),
                Timeline(tweets),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
