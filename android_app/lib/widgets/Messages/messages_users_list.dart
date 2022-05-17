import 'package:flutter/material.dart';
import 'messages_user.dart';
import 'DM.dart';

class MessagesUsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (DM(
                      username: 'Nader',
                    )),
                  ),
                );
              },
              child: MessagesUser(
                'Nader',
                'nido7',
              ),
            ),
            MessagesUser('Ahmed', 'ahmedMoh123'),
            MessagesUser('Mostafa', 'Mostafa7'),
            MessagesUser('Moaz', 'moaz5657'),
          ],
        ),
      ),
    );
  }
}
