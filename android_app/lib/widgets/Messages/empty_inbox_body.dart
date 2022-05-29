import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'messages_users_list.dart';

class EmptyInboxBody extends StatefulWidget {
  @override
  State<EmptyInboxBody> createState() => _EmptyInboxBodyState();
}

class _EmptyInboxBodyState extends State<EmptyInboxBody> {
  bool isAndroid = true;

  double screenWidth = 0;

  double screenHeight = 0;

  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 250),
              const Text(
                'Welcome to your inbox!',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'RalewayMedium',
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 290,
                child: Text(
                  'Drop a line, share Tweets and more with private conversations between you and others on Twitter.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SizedBox(
                    width: isAndroid
                        ? screenWidth * (30 / 360)
                        : screenWidth * 0.39,
                  ),
                  SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => _goToUsersList(context),
                      child: const Text(
                        'Write a message',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToUsersList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return MessagesUsersList();
      }),
    );
  }

  void startAddNewMessage(BuildContext ctx) {
    var tweetTextController = TextEditingController();
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Cancel'),
                ),
                const Spacer(),
              ],
            ),
            //add tweet
            Container(
              padding: const EdgeInsets.all(10),
              //take input text from user
              child: TextField(
                decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 14.5,
                  ),
                  hintText: 'What\'s happening?',
                ),
                controller: tweetTextController,
              ),
            )
          ],
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      useRootNavigator: true,
    );
  }
}
