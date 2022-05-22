import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'messages_user.dart';
import 'DM.dart';
import 'chat_page.dart';

class MessagesUsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(
            fontFamily: 'RalewayMedium',
          ),
        ),
      ),
      body: SizedBox(
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
            InkWell(
              child: MessagesUser('Ahmed', 'ahmedMoh123'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (ChatPage(username: 'Ahmed')),
                  ),
                );
              },
            ),
            MessagesUser('Mostafa', 'Mostafa7'),
            MessagesUser('Moaz', 'moaz5657'),
          ],
        ),
      ),
    );
  }
}
