import 'package:flutter/material.dart';

class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () => {}), //button should open to side bar,
        actions: [
          Container(
            width: 260,
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7.0),
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Search Direct Messages',
              ),
            ),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // button should open the what's happening page
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
