import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  bool left;

  String messageText;
  Message({required this.left, required this.messageText});

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
                  left: left ? 0 : screenWidth * 0.62,
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
