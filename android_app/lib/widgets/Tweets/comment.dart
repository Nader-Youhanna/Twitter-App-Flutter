import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  int commentCount = 0;
  Color commentColor = Colors.grey;
  final int iconSize;

  Comment(this.commentCount, this.iconSize);
  @override
  State<Comment> createState() => _CommentState(commentCount, iconSize);
}

class _CommentState extends State<Comment> {
  int commentCount = 0;
  Color commentColor = Colors.grey;
  final int iconSize;

  _CommentState(this.commentCount, this.iconSize);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Comment Pressed');
        setState(() {
          commentCount++;
        });
      },
      icon: Image.asset(
        'assets/images/comment_icon.png',
        width: iconSize.toDouble(),
        height: iconSize.toDouble(),
      ),
      label: Text(
        commentCount.toString(),
        style: TextStyle(color: commentColor),
      ),
    );
  }
}
