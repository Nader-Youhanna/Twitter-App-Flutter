import '/widgets/Tweets/tweet.dart';
import 'package:flutter/material.dart';

class CommentButton extends StatefulWidget {
  int _commentators;
  final Color commentColor = Colors.grey;
  final int iconSize;
  final Tweet tweet;
  late String _userName;

  CommentButton(this._commentators, this.iconSize, this.tweet, {Key? key})
      : super(key: key);

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
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

  void _addComment(BuildContext ctx) {
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
                        Navigator.pop(ctx);
                      },
                      child: Text('Reply'),
                    ),
                  ],
                ),
                //Tweet that is being replied to
                widget.tweet,
                //Replying to @username
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text('Replying to ' + widget._userName),
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tweet your reply',
                  ),
                ),
              ],
            ),
          );
        });
  }
}
