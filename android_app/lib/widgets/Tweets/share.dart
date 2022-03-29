import 'package:flutter/material.dart';

class Share extends StatelessWidget {
  final int iconSize;

  Share(this.iconSize);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('Share pressed');
      },
      child: Image.asset(
        'assets/images/share_icon.png',
        width: iconSize.toDouble(),
        height: iconSize.toDouble(),
      ),
    );
  }
}
