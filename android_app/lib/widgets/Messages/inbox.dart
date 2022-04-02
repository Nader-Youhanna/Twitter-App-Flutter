import 'package:android_app/widgets/Messages/empty_inbox_body.dart';
import 'package:android_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';

class Inbox extends StatefulWidget {
  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  var _inboxIsEmpty = true;
  var _appBarText = 'Search Direct Messages';
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar test
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: const Icon(Icons
                .person_rounded), //should be changed to google profile icon
            color: Colors.black,
            onPressed: () =>
                {_goToUserProfile(context)}), //button should open to side bar,
        actions: [
          Container(
            width: 260,
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintStyle: const TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 14.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: _appBarText,
              ),
            ),
          ),

          IconButton(
              icon: const Icon(Icons.settings_outlined),
              color: Colors.black,
              onPressed: () => {}), //button shoud direct to setings
        ],
      ),
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
