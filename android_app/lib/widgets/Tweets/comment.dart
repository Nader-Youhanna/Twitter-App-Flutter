import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  int commentCount;
  final Color commentColor = Colors.grey;
  final int iconSize;

  Comment(this.commentCount, this.iconSize);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Comment Pressed');
        setState(() {
          widget.commentCount++;
        });
      },
      icon: Image.asset(
        'assets/images/comment_icon.png',
        width: widget.iconSize.toDouble(),
        height: widget.iconSize.toDouble(),
      ),
      label: Text(
        widget.commentCount.toString(),
        style: TextStyle(color: widget.commentColor),
      ),
    );
  }
}
