// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './retweet.dart';
import './like.dart';
import './comment.dart';
import './share.dart';
import './tweetImage.dart';

class Tweet extends StatelessWidget {
  final int
      _userId; //The user who tweeted it. This is needed to get profilePicture, userName and userDisplayName

  final DateTime _createdAt;
  final String _tweetText;
  final CircleAvatar _userImage = CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 20.0,
  ); //This will be the profile picture of the user who tweeted it. Get it from userId
  final List<String> _tweetImages;
  final List<int>
      _favouriters; //List of userIds of users who favourited this tweet
  final List<int>
      _retweeters; //List of userIds of users who retweeted this tweet
  final List<int>
      _commenters; //List of userIds of users who commented on this tweet
  final int _iconSize = 20;

  late String _username;
  late String _displayName;

  Tweet(
    Key? key,
    this._userId,
    this._createdAt,
    this._tweetText,
    this._tweetImages,
    this._favouriters,
    this._retweeters,
    this._commenters,
  ) {
    //Get username and displayName from userId
    _username = '@username . ';
    _displayName = 'Display Name';
  }

  Tweet.jsonTweet(List jsonTweet)
      : this._userId = jsonTweet[0],
        this._createdAt = DateTime.parse(jsonTweet[1]),
        this._tweetText = jsonTweet[2],
        this._tweetImages = jsonTweet[3],
        this._favouriters = jsonTweet[4],
        this._retweeters = jsonTweet[5],
        this._commenters = jsonTweet[6];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Card(
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
                    child: Text(
                      _displayName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  //User name
                  Container(
                    child: Text(
                      _username,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  //Created date
                  Container(
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                ],
              ),
              //Tweet text
              Container(
                child: Text(
                  _tweetText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                padding: EdgeInsets.all(5),
                width: mediaQuery.size.width - _userImage.radius! - 30,
              ),
              if (_tweetImages.isNotEmpty) TweetImage(_tweetImages),

              //Row for retweet, comment, like
              Row(
                children: [
                  //Comment
                  Comment(_commenters.length, _iconSize),
                  //Retweet
                  Retweet(5, false, _iconSize),
                  //Like
                  Like(_favouriters.length, false, _iconSize),
                  //Share
                  Share(_iconSize),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
