import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int totalCount;

  NotificationBadge({required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "$totalCount",
            // ignore: prefer_const_constructors
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
