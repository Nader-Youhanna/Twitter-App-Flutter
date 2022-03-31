import 'package:android_app/widgets/Messages/empty_inbox_body.dart';
import 'package:android_app/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  var _inboxIsEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _inboxIsEmpty ? EmptyInboxBody() : EmptyInboxBody(),
      // bottomNavigationBar: MyNavigationBar(),
      floatingActionButton: FloatingActionButton(
        // button should open the what's happening page
        onPressed: () => {},
        child: const Icon(
          Icons.mail,
          size: 30,
        ),
      ),
    );
  }
}
