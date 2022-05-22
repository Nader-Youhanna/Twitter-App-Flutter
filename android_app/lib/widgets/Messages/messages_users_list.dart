import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'messages_user.dart';
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
                    builder: (context) =>
                        (ChatPage(name: 'Nader', username: 'ahmed')),
                  ),
                );
              },
              child: MessagesUser(
                name: 'Nader',
                username: 'nido7',
              ),
            ),
            InkWell(
              child: MessagesUser(name: 'Ahmed', username: 'ahmed'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        (ChatPage(name: 'Ahmed', username: 'ahmed')),
                  ),
                );
              },
            ),
            InkWell(
              child: MessagesUser(name: 'Mostafa', username: 'Mostafa7'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        (ChatPage(name: 'Mostafa', username: 'ahmed')),
                  ),
                );
              },
            ),
            InkWell(
              child: MessagesUser(name: 'Moaz', username: 'moaz5657'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        (ChatPage(name: 'Moaz', username: 'ahmed')),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
