// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:android_app/constants.dart';
import 'package:android_app/functions/http_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../functions/tweet_functions.dart';
import './retweet.dart';
import './like.dart';
import './commentButton.dart';
import './share.dart';
import './tweetImage.dart';

/// This class is used to represent a tweet.
class Tweet extends StatelessWidget {
  //Tweet id
  final String _key;
  late String _username;
  late String _displayName;
  String _email;

  CircleAvatar _userImage = CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 20.0,
  ); //This will be the profile picture of the user who tweeted it. Get it from userId
  late final String _tweetBody;
  List<String> _tweetMedia = <String>[];
  List<String> _hashtags = <String>[];
  int _repliesCount;
  int _retweetersCount;
  int _favouritersCount;

  GlobalKey gKey = GlobalKey();

  bool _isLiked;
  bool _isRetweeted;
  bool _isBookmarked;

  //final DateTime _updatedAt;
  final DateTime _createdAt;
  late final List<String> _taggedUsers;

  final int _iconSize = 20;

  final bool _hideButtons;
  bool _hideReplyTo;

  String _replyToUsername = "";

  Tweet.jsonTweet(
      Map<String, dynamic> jsonTweet, bool hideButtons, bool hideReplyTo)
      : _key = jsonTweet['key'] as String,
        _username = jsonTweet['username'] as String,
        _displayName = jsonTweet['name'] as String,
        _email = jsonTweet['email'] as String,
        _tweetBody = jsonTweet['tweetBody'] as String,
        _repliesCount = jsonTweet['repliesCount'] as int,
        _retweetersCount = jsonTweet['retweetersCount'] as int,
        _favouritersCount = jsonTweet['favoritersCount'] as int,
        _createdAt = DateTime.parse(
          jsonTweet['createdAt'] as String,
        ),

        //_userId = jsonTweet['userId'] as int,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo,
        _isLiked =
            jsonTweet['isLikedByUser'].toString().toLowerCase() == 'true',
        _isRetweeted =
            jsonTweet['isRetweetedByUser'].toString().toLowerCase() == 'true',
        _isBookmarked =
            jsonTweet['isBookmarkedByUser'].toString().toLowerCase() == 'true' {
    _tweetMedia = List<String>.from(jsonTweet['tweetMedia']);

    _taggedUsers = List<String>.from(jsonTweet['taggedUsers']);
    if (jsonTweet['hashtags'] != null) {
      _hashtags = List<String>.from(jsonTweet['hashtags']);
    } else {
      _hashtags = <String>[];
    }

    //set _userImage
    if (jsonTweet['userImage'] != null) {
      print(jsonTweet['userImage']);
      _userImage = CircleAvatar(
        backgroundImage: NetworkImage(jsonTweet['userImage'], scale: 1.0),
        backgroundColor: Colors.transparent,
        radius: 20.0,
      );
    }
  }

  Tweet.jsonReply2(
      Map<String, dynamic> jsonReply, bool hideButtons, bool hideReplyTo)
      : _key = jsonReply['key'] as String,
        _username = jsonReply['username'] as String,
        _displayName = jsonReply['name'] as String,
        _email = jsonReply['email'] as String,
        _repliesCount = jsonReply['repliesCount'] as int,
        _retweetersCount = jsonReply['retweetersCount'] as int,
        _favouritersCount = jsonReply['favoritersCount'] as int,
        _createdAt = DateTime.parse(
          jsonReply['createdAt'] as String,
        ),

        //_userId = jsonTweet['userId'] as int,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo,
        _isLiked =
            jsonReply['isLikedByUser'].toString().toLowerCase() == 'true',
        _isRetweeted =
            jsonReply['isRetweetedByUser'].toString().toLowerCase() == 'true',
        _isBookmarked =
            jsonReply['isBookmarkedByUser'].toString().toLowerCase() == 'true' {
    if (jsonReply['replyBody'] != null) {
      _tweetBody = jsonReply['replyBody'] as String;
    } else {
      _tweetBody = "";
    }
    if (jsonReply['hashtags'] != null) {
      _hashtags = List<String>.from(jsonReply['hashtags']);
    } else {
      _hashtags = <String>[];
    }
    _tweetMedia = List<String>.from(jsonReply['media']);

    _taggedUsers = List<String>.from(jsonReply['taggedUsers']);

    //set _userImage
    if (jsonReply['image'] != null) {
      //print(jsonReply['image']);
      _userImage = CircleAvatar(
        backgroundImage: NetworkImage(jsonReply['image'], scale: 1.0),
        backgroundColor: Colors.transparent,
        radius: 20.0,
      );
    } else {
      print("no image");
      _userImage = CircleAvatar(
        backgroundImage: AssetImage('assets/images/user_icon.png'),
        radius: 20.0,
      );
    }
  }

  Tweet.jsonTweetByID(
      Map<String, dynamic> jsonTweetByID, bool hideButtons, bool hideReplyTo)
      : _key = "",
        _username = jsonTweetByID['username'] as String,
        _displayName = jsonTweetByID['name'] as String,
        _email = jsonTweetByID['email'] as String,
        _tweetBody = jsonTweetByID['tweetBody'] as String,
        _repliesCount = jsonTweetByID['repliesCount'] as int,
        _retweetersCount = jsonTweetByID['retweetersCount'] as int,
        _favouritersCount = jsonTweetByID['favoritersCount'] as int,
        _createdAt = DateTime.parse(
          jsonTweetByID['createdAt'] as String,
        ),

        //_userId = jsonTweet['userId'] as int,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo,
        _isLiked =
            jsonTweetByID['isLikedByUser'].toString().toLowerCase() == 'true',
        _isRetweeted =
            jsonTweetByID['isRetweetedByUser'].toString().toLowerCase() ==
                'true',
        _isBookmarked =
            jsonTweetByID['isBookmarkedByUser'].toString().toLowerCase() ==
                'true' {
    _tweetMedia = List<String>.from(jsonTweetByID['tweetMedia']);

    _taggedUsers = List<String>.from(jsonTweetByID['taggedUsers']);

    //set _userImage
    if (jsonTweetByID['userImage'] != null) {
      _userImage = CircleAvatar(
        backgroundImage: NetworkImage(jsonTweetByID['userImage'], scale: 1.0),
        backgroundColor: Colors.transparent,
        radius: 20.0,
      );
    }
  }
  Tweet.jsonTrendingTweet(Map<String, dynamic> jsonTrendingTweet,
      bool hideButtons, bool hideReplyTo)
      : _key = jsonTrendingTweet['_id'],
        _username = "dummy",
        _displayName = "dummy",
        _email = "dummy",
        _tweetBody = jsonTrendingTweet['body'] as String,
        _repliesCount = 0,
        _retweetersCount = 0,
        _favouritersCount = 0,
        _createdAt = DateTime.parse(
          jsonTrendingTweet['createdAt'] as String,
        ),

        //_userId = jsonTweet['userId'] as int,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo,
        _isLiked = false,
        _isRetweeted = false,
        _isBookmarked = false,
        _tweetMedia = List<String>.from(jsonTrendingTweet['media']),
        _taggedUsers = List<String>.from(jsonTrendingTweet['taggedUsers']);

  Tweet.jsonReply(
      Map<String, dynamic> jsonTweet, bool hideButtons, bool hideReplyTo)
      : _key = "",
        _username = jsonTweet['username'] as String,
        _displayName = jsonTweet['name'] as String,
        _email = jsonTweet['email'] as String,
        _tweetBody = jsonTweet['replyBody'] as String,
        _repliesCount = 0,
        _retweetersCount = 0,
        _favouritersCount = 0,

        //_updatedAt = DateTime.parse(jsonTweet['updatedAt'] as String),
        _createdAt = DateTime.parse(jsonTweet['createdAt'] as String),

        //_userId = jsonTweet['userId'] as int,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo,
        _isLiked =
            jsonTweet['isLikedByUser'].toString().toLowerCase() == 'true',
        _isRetweeted =
            jsonTweet['isRetweetedByUser'].toString().toLowerCase() == 'true',
        _isBookmarked =
            jsonTweet['isBookmarkedByUser'].toString().toLowerCase() == 'true' {
    _tweetMedia = List<String>.from(jsonTweet['media']);

    _taggedUsers = List<String>.from(jsonTweet['taggedUsers']);
  }
  Tweet.JsonUserProfileTweet(Map<String, dynamic> jsonTrendingTweet,
      bool hideButtons, bool hideReplyTo)
      : _key = jsonTrendingTweet['_id'],
        _username = jsonTrendingTweet['username'],
        _displayName = jsonTrendingTweet['name'],
        _email = "dummy",
        _tweetBody = jsonTrendingTweet['body'] as String,
        _repliesCount = 0,
        _retweetersCount = 0,
        _favouritersCount = 0,
        _createdAt = DateTime.parse(
          jsonTrendingTweet['createdAt'] as String,
        ),

        //_userId = jsonTweet['userId'] as int,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo,
        _isLiked = false,
        _isRetweeted = false,
        _isBookmarked = false,
        _tweetMedia = List<String>.from(jsonTrendingTweet['media']),
        _taggedUsers = List<String>.from(jsonTrendingTweet['taggedUsers']);

  /*
    Tweet.jsonTweet(
      Map<String, dynamic> jsonTweet, bool hideButtons, bool hideReplyTo)
      : _userId = jsonTweet['userId'] as int,
        _createdAt = DateTime.parse(jsonTweet['createdAt']),
        _tweetBody = jsonTweet['tweetText'] as String,
        _hideButtons = hideButtons,
        _hideReplyTo = hideReplyTo {
    _tweetMedia = List<String>.from(jsonTweet['images']);
    _favouritersCount = List<int>.from(jsonTweet['favouriters']);
    _retweetersCount = List<int>.from(jsonTweet['retweeters']);
    _repliesCount = List<Map<String, dynamic>>.from(jsonTweet['replies']);

    _username = '@username';
    _displayName = 'Display Name';
  }


  */
  // Map<String, dynamic> toJson() => {
  //       'userId': _userId,
  //       'createdAt': _createdAt.toString(),
  //       'tweetText': _tweetBody,
  //       'images': _tweetMedia,
  //       'favouriters': _favouritersCount,
  //       'retweeters': _retweetersCount,
  //       'replies': _repliesCount,
  //     };

  Map<String, dynamic> toJson() => {
        'key': _key,
        'username': _username,
        'name': _displayName,
        'email': _email,
        'tweetBody': _tweetBody,
        'tweetMedia': _tweetMedia,
        'repliesCount': _repliesCount,
        'retweetersCount': _retweetersCount,
        'favoritersCount': _favouritersCount,
        //'updatedAt': _updatedAt.toString(),
        'createdAt': _createdAt.toString(),
        'taggedUsers': _taggedUsers,
        'isLikedByUser': _isLiked,
        'isRetweetedByUser': _isRetweeted,
        'isBookmarkedByUser': _isBookmarked,
        'hashtags': _hashtags,

        //'userId': _userId,
      };

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    //get replies
    List<Widget> replies = [];
    return InkWell(
      onTap: () {
        print("Tweet pressed");
        print("No. of replies = " + _repliesCount.toString());
        showModalBottomSheet(
            isScrollControlled: true,
            enableDrag: false,
            useRootNavigator: true,
            context: context,
            builder: (bCtx) {
              return FutureBuilder<Widget>(
                future: showReplies(context),
                builder: (BuildContext ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    replies.add(snapshot.data!);
                    return snapshot.data ??
                        Container(child: Text("No replies"));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      height: mediaQuery.size.height * 0.5,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Text("${snapshot.error}");
                },
              );
            });
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image widget
            _userImage,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //User display name
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        _displayName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //User name
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "$_username . ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    //Created date
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                //Replying to
                if (!_hideReplyTo)
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Replying to $_username . ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                //Tweet text
                Container(
                  padding: EdgeInsets.all(5),
                  width: mediaQuery.size.width - _userImage.radius! - 30,
                  child: Text(
                    _tweetBody,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (_tweetMedia.isNotEmpty) TweetImage(_tweetMedia),

                //Row for retweet, comment, like
                if (!_hideButtons)
                  Row(
                    children: [
                      //Comment
                      CommentButton(_repliesCount, _iconSize, this),
                      //Retweet
                      Retweet(
                          _retweetersCount, _isRetweeted, _iconSize, retweet),
                      //Like
                      Like(_favouritersCount, _isLiked, _iconSize, like),
                      //Share
                      Share(_iconSize),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Show replies
  Future<Widget> showReplies(BuildContext context) async {
    var replies = await getReplies(_key.toString(), _username);

    var repliesWidget = <Widget>[];
    repliesWidget.add(this);
    for (int i = 0; i < replies.length; i++) {
      repliesWidget
          .add(Tweet.jsonTweet(replies.elementAt(i).toJson(), false, false));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        Expanded(
          child: ListView(
            children: repliesWidget,
          ),
        ),
      ],
    );
  }

  // like function
  void like() async {
    //print(_key);
    String url = URL.likeTweet;
    url = url.replaceAll(":tweetId", _key);
    //print(url);

    Map<String, String> headersMap = {
      'Content-Type': 'application/json',
      'Authorization': constToken
    };
    var response = await httpRequestPost(url, {}, headersMap);

    if (response['message'] == 'added like') {
      _favouritersCount++;
      _isLiked = true;
    } else if (response['message'] == 'removed like') {
      _favouritersCount--;
      _isLiked = false;
    } else {
      print("Error liking the tweet. Response is " + response['message']);
    }
  }

  // retweet function
  void retweet() async {
    //print(_key);
    String url = URL.retweet;
    url = url.replaceAll(":tweetId", _key);
    //print("URL is " + url);

    Map<String, String> headersMap = {
      'Content-Type': 'application/json',
      'Authorization': constToken
    };
    var response = await httpRequestPost(url, {}, headersMap);

    if (response['message'] != null) {
      _retweetersCount++;
      _isRetweeted = true;
    } else if (response['message'] == 'unretweeted') {
      _retweetersCount--;
      _isRetweeted = false;
    } else {
      print("Error retweeting the tweet. Response is " + response['message']);
    }
  }

  /// Returns the username
  String getUserName() {
    return _username;
  }

  /// Returns the display name
  String getDisplayName() {
    return _displayName;
  }

  /// Returns the tweet text
  String getTweetText() {
    return _tweetBody;
  }

  /// Returns the tweet media
  List<String> getTweetImages() {
    return _tweetMedia;
  }

  /// Returns the favouriters count
  int getFavouriters() {
    return _favouritersCount;
  }

  /// Returns the retweeters count
  int getRetweetersCount() {
    return _retweetersCount;
  }

  /// Returns the replies count
  int getCommentersCount() {
    return _repliesCount;
  }

  // int getUserId() {
  //   return _userId;
  // }

  /// Returns the created date
  DateTime getCreatedAt() {
    return _createdAt;
  }

  /// Returns the user date
  CircleAvatar getUserImage() {
    return _userImage;
  }

  /// Sets the reply to username
  void setReplyTo(String username) {
    _username = username;
  }

  //get tweed id
  String getTweetId() {
    return _key;
  }
}
