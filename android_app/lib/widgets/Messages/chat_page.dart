import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'message.dart';
import 'package:flutter/material.dart';

import 'messages_user.dart';

class ChatPage extends StatefulWidget {
  String username;
  String name;

  ChatPage({required this.name, required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messages = [];

  var users = [];

  void initState() {
    super.initState();
    setState(() {
      //Fetch data from BD
      users = <MessagesUser>[
        MessagesUser(username: 'nido', name: 'Nader'),
        MessagesUser(username: 'ahmed', name: 'Ahmed'),
      ];
      messages = <Message>[
        Message(messageText: 'Bye', user: users[1]),
        Message(messageText: 'See you later', user: users[0]),
        Message(messageText: 'I\'m fine too', user: users[1]),
        Message(messageText: 'And you ?', user: users[0]),
        Message(messageText: 'I\'m fine', user: users[0]),
        Message(messageText: 'How are you?', user: users[1]),
        Message(messageText: 'Hello', user: users[0]),
        Message(messageText: 'Bye', user: users[1]),
        Message(messageText: 'See you later', user: users[0]),
        Message(messageText: 'I\'m fine too', user: users[1]),
        Message(messageText: 'And you ?', user: users[0]),
        Message(messageText: 'I\'m fine', user: users[0]),
        Message(messageText: 'How are you?', user: users[1]),
        Message(messageText: 'Hello', user: users[0]),
      ];
    });
  }

  Widget _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
        color: isMe ? const Color(0xAACCBFFF) : const Color(0xFFDFEFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.time,
            style: TextStyle(
              color: isMe
                  ? Color.fromARGB(255, 159, 108, 174)
                  : Color.fromARGB(255, 130, 164, 190),
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(message.messageText,
              style: TextStyle(
                color: isMe ? Color.fromARGB(255, 90, 5, 136) : Colors.black,
              )),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: [
        msg,
        IconButton(
          onPressed: () {
            setState(() {
              message.isHearted = !message.isHearted;
            });
          },
          icon: message.isHearted
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.name,
            style: const TextStyle(
              fontFamily: 'RalewayMedium',
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    Message message = messages[index];
                    final bool isMe = message.user.username == widget.username;
                    print(
                        "Message username: ${message.user.username} - Widget.username: ${widget.username}");
                    return _buildMessage(message, isMe);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
