import 'package:flutter/material.dart';

class EmptyInboxBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {},
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
    );
  }
}
