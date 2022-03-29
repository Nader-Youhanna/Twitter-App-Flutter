import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import './notificationBar.dart';
import './allNotificationsList.dart';
import './mentionsList.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const NotificationBar(), //the bar that gives us either the all notifications page or the mentions page
              ];
            },
            body: const TabBarView(
              children: <Widget>[
                AllNotificationsList(), //getting and displaying the list of all notifications
                MentionsList(), //getting and displaying the list of all mentions
              ],
            ),
          ),
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          // button should open the what's happening page
          onPressed: () => {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
