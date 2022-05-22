import 'package:flutter/material.dart';
import 'messages_user.dart';

class Message extends StatelessWidget {
  bool left = false;
  MessagesUser user;
  String messageText;
  String time = '02:30 PM';

  Message({
    required this.messageText,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        SizedBox(width: screenWidth * 0.025),
        Column(
          children: [
            SizedBox(height: screenWidth * 0.1),
            Card(
              color: left ? Colors.blue : Colors.white,
              elevation: 10,
              margin: EdgeInsets.only(
                  left: left ? 0 : screenWidth * 0.6,
                  right: left ? screenWidth * 0.1 : 0),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Text(
                        messageText,
                        style: TextStyle(
                          color: left ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
