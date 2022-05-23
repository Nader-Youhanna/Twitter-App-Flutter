import 'package:android_app/functions/tweet_functions.dart';

import './tweet.dart';
import 'package:flutter/material.dart';

/// This class is used to represent comment button in a tweet.
class CommentButton extends StatefulWidget {
  int _commentators;
  final Color commentColor = Colors.grey;
  final int iconSize;
  Tweet tweet;
  late String _userName;
  String _token;

  CommentButton(this._commentators, this.iconSize, this.tweet, this._token,
      {Key? key})
      : super(key: key);

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  List<Widget> _commentWidgets = <Widget>[];
  var _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    widget._userName = widget.tweet.getUserName();
    return TextButton.icon(
      onPressed: () => _addComment(context),
      icon: Image.asset(
        'assets/images/comment_icon.png',
        width: widget.iconSize.toDouble(),
        height: widget.iconSize.toDouble(),
      ),
      label: Text(
        widget._commentators.toString(),
        style: TextStyle(color: widget.commentColor),
      ),
    );
  }

  /// This function opens the modal sheet to add a new comment and send it to the backend.
  void _addComment(BuildContext ctx) async {
    var repliesWidgets = await showReplies();

    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        enableDrag: false,
        useRootNavigator: true,
        builder: (bCtx) {
          return SizedBox(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        //TODO Send comment to server
                        String comment = _commentController.text;
                        _commentController.clear();
                        //search for hashtag
                        RegExp exp = RegExp(r'#\w+');
                        Iterable<RegExpMatch> matches = exp.allMatches(comment);
                        List<String> hashtags = [];
                        for (var match in matches) {
                          String hashtag = match.group(0)!;
                          //remove the #
                          hashtag = hashtag.substring(1);

                          hashtags.add(hashtag);
                        }

                        //search for tagged users
                        List<String> taggedUsers = [];
                        exp = RegExp(r'@[a-zA-Z0-9]+');
                        matches = exp.allMatches(comment);
                        for (var match in matches) {
                          taggedUsers.add(match.group(0)!);
                        }

                        var data = {
                          "body": comment,
                          "taggedUsers": taggedUsers,
                          "hashtags": hashtags,
                        };

                        //send data to server
                        var response = await addComment(
                            widget.tweet.getTweetId(), data, widget._token);

                        Navigator.pop(ctx);
                      },
                      child: const Text('Reply'),
                    ),
                  ],
                ),
                //Tweet that is being replied to
                widget.tweet,
                Container(
                  height: MediaQuery.of(ctx).size.height * 0.5,
                  child: ListView.builder(
                      itemBuilder: (bCtx, index) {
                        return repliesWidgets[index];
                      },
                      itemCount: repliesWidgets.length),
                ),
                //Replying to @username
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text('Replying to ' + widget._userName),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tweet your reply',
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<List<Widget>> showReplies() async {
    var replies = await getReplies(widget.tweet.getTweetId().toString(),
        widget.tweet.getUserName(), widget._token);

    var repliesWidget = <Widget>[];
    for (int i = 0; i < replies.length; i++) {
      repliesWidget.add(Tweet.jsonTweet(
          replies.elementAt(i).toJson(), false, false, widget._token));
    }
    return repliesWidget;
  }
}
