import 'package:flutter/material.dart';

/// This class is used to represent retweet button in a tweet.
class Retweet extends StatefulWidget {
  int retweetCount = 0;
  Color retweetColor = Colors.grey;
  bool isRetweeted = false;
  final int iconSize;

  Function retweet;

  Retweet(
      this.retweetCount, this.isRetweeted, this.iconSize, Function onPressed,
      {Key? key})
      : retweet = onPressed,
        super(key: key) {
    if (isRetweeted) {
      retweetColor = Colors.green;
    }
  }

  @override
  State<Retweet> createState() => _RetweetState();
}

class _RetweetState extends State<Retweet> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Retweet Pressed');

        setState(() {
          if (widget.isRetweeted) {
            widget.retweetColor = Colors.grey;
            widget.isRetweeted = false;
            widget.retweetCount--;
          } else {
            widget.retweetColor = Colors.green;
            widget.isRetweeted = true;
            widget.retweetCount++;
          }
        });
        widget.retweet();
      },
      icon: Image.asset(
        'assets/images/retweet_icon.png',
        width: widget.iconSize.toDouble(),
        height: widget.iconSize.toDouble(),
        color: widget.retweetColor,
      ),
      label: Text(
        widget.retweetCount.toString(),
        style: TextStyle(color: widget.retweetColor),
      ),
    );
  }
}
