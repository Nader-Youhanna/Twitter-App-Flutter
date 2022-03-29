import 'package:flutter/material.dart';

class Retweet extends StatefulWidget {
  int retweetCount = 0;
  Color retweetColor = Colors.grey;
  bool isRetweeted = false;
  final int iconSize;

  Retweet(this.retweetCount, this.isRetweeted, this.iconSize);

  @override
  State<Retweet> createState() =>
      _RetweetState(retweetCount, isRetweeted, iconSize);
}

class _RetweetState extends State<Retweet> {
  int retweetCount = 2;
  Color retweetColor = Colors.grey;
  bool isRetweeted = false;
  final int iconSize;

  _RetweetState(
    this.retweetCount,
    this.isRetweeted,
    this.iconSize,
  );

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        print('Retweet Pressed');
        setState(() {
          if (isRetweeted) {
            retweetColor = Colors.grey;
            isRetweeted = false;
            retweetCount--;
          } else {
            retweetColor = Colors.green;
            isRetweeted = true;
            retweetCount++;
          }
        });
      },
      icon: Image.asset(
        'assets/images/retweet_icon.png',
        width: iconSize.toDouble(),
        height: iconSize.toDouble(),
        color: retweetColor,
      ),
      label: Text(
        retweetCount.toString(),
        style: TextStyle(color: retweetColor),
      ),
    );
  }
}
