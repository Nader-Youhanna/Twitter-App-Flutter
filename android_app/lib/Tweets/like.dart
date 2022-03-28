import 'package:flutter/material.dart';

class Like extends StatefulWidget {
  int likeCount = 0;
  Color likeColor = Colors.grey;
  bool isLiked = false;
  final int iconSize;

  Like(this.likeCount, this.isLiked, this.iconSize);

  @override
  State<Like> createState() =>
      _LikeState(this.likeCount, this.isLiked, this.iconSize);
}

class _LikeState extends State<Like> {
  int likeCount;
  Color likeColor = Colors.grey;
  bool isLiked;
  final int iconSize;

  _LikeState(
    this.likeCount,
    this.isLiked,
    this.iconSize,
  );
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Like Pressed');
        setState(() {
          if (isLiked) {
            likeColor = Colors.grey;
            isLiked = false;
            likeCount--;
          } else {
            likeColor = Colors.red;
            isLiked = true;
            likeCount++;
          }
        });
      },
      icon: Image.asset(
        'assets/images/like_icon.png',
        width: iconSize.toDouble(),
        height: iconSize.toDouble(),
        color: likeColor,
      ),
      label: Text(
        likeCount.toString(),
        style: TextStyle(color: likeColor),
      ),
    );
  }
}
