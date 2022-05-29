import 'package:flutter/material.dart';

/// This class is used to represent share button in a tweet.
class Bookmark extends StatefulWidget {
  final int iconSize;
  bool isBookmarked;
  Function onPressed;

  Bookmark(this.iconSize, this.isBookmarked, this.onPressed);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Color iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    if (widget.isBookmarked) {
      setState(() {
        iconColor = Colors.red;
      });
    }
    return IconButton(
      icon: Icon(
        Icons.bookmark_outline,
        size: widget.iconSize.toDouble(),
        color: iconColor,
      ),
      onPressed: () {
        print('Bookmark pressed');
        widget.onPressed();
        //change color
        setState(() {
          if (widget.isBookmarked) {
            widget.isBookmarked = false;
            iconColor = Colors.black;
          } else {
            widget.isBookmarked = true;
            iconColor = Colors.red;
          }
        });
      },
    );
  }
}
