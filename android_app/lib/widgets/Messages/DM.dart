import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'message.dart';

class DM extends StatelessWidget {
  String username;

  DM({required this.username});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(children: [
        const SizedBox(height: 20),
        Message(left: true, messageText: 'Hello'),
        Message(left: false, messageText: 'Hello Neighbour'),
        Message(left: true, messageText: 'How are you doing ?'),
        Message(left: false, messageText: 'I\'m fine and you ?'),
        Message(left: true, messageText: 'I\'m fine too'),
        SizedBox(height: screenHeight * 0.1),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.025),
            SizedBox(
              width: screenWidth * 0.01,
              height: screenHeight * 0.05,
              child: const TextField(
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 14.5,
                  ),
                  hintText: 'What\'s happening?',
                ),
                //controller: tweetTextController,
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
          ],
        ),
      ]),
    );
  }
}
