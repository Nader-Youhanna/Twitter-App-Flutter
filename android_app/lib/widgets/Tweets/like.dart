import 'package:flutter/material.dart';

class Like extends StatefulWidget {
  int likeCount = 0;
  Color likeColor = Colors.grey;
  bool isLiked = false;
  final int iconSize;

  Like(this.likeCount, this.isLiked, this.iconSize);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Like Pressed');
        setState(() {
          if (widget.isLiked) {
            widget.likeColor = Colors.grey;
            widget.isLiked = false;
            widget.likeCount--;
          } else {
            widget.likeColor = Colors.red;
            widget.isLiked = true;
            widget.likeCount++;
          }
        });
      },
      icon: Image.asset(
        'assets/images/like_icon.png',
        width: widget.iconSize.toDouble(),
        height: widget.iconSize.toDouble(),
        color: widget.likeColor,
      ),
      label: Text(
        widget.likeCount.toString(),
        style: TextStyle(color: widget.likeColor),
      ),
    );
  }
}
