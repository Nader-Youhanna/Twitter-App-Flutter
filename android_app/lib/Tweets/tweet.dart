// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import './retweet.dart';
import './like.dart';
import './comment.dart';
import './share.dart';

class Tweet extends StatelessWidget {
  // final user;
  // final text;
  // final images;
  // final date;
  // final int likes;
  // final retweets;
  // final comments;
  // final bool isLiked;
  // final bool isRetweeted;
  // final bool isShared;
  // final bool isReply;
  // final bool isReplyAll;
  // final bool isDirectMessage;
  // final bool isMention;
  // final bool isPinned;
  // final bool isSaved;
  // final bool isEdited;
  // final bool isDeleted;
  // final bool isRepost;

  CircleAvatar userImage = CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon.png'),
    radius: 20.0,
  );

  String tweetText = "This is the text inside the tweet";

  Image tweetImage = Image(
    image: AssetImage('assets/images/test_image.png'),
    width: 200.0,
    height: 200.0,
  );

  int commentCount = 3;
  int likeCount = 4;

  int iconSize = 20;

  // Tweet(
  //     {required this.user,
  //     required this.text,
  //     required this.images,
  //     required this.date,
  //     required this.likes,
  //     required this.retweets,
  //     required this.comments,
  //     required this.isLiked,
  //     required this.isRetweeted,
  //     required this.isShared,
  //     required this.isReply,
  //     required this.isReplyAll,
  //     required this.isDirectMessage,
  //     required this.isMention,
  //     required this.isPinned,
  //     required this.isSaved,
  //     required this.isEdited,
  //     required this.isDeleted,
  //     required this.isRepost});

  Tweet(this.tweetText, this.tweetImage, this.commentCount, this.likeCount);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image widget
          userImage,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    child: Text(
                      '@username . ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
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
              Container(
                child: Text(
                  tweetText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                padding: EdgeInsets.all(5),
                width: mediaQuery.size.width - userImage.radius! - 30,
              ),
              if (tweetImage != null)
                Container(
                  child: tweetImage,
                  padding: EdgeInsets.all(5),
                ),

              //Row for retweet, comment, like
              Row(
                children: [
                  //Comment
                  Comment(commentCount, iconSize),
                  //Retweet
                  Retweet(5, false, iconSize),
                  //Like
                  Like(likeCount, false, iconSize),
                  //Share
                  Share(iconSize),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
