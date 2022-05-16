import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../../functions/tweet_functions.dart';
import 'notification_bar.dart';
import 'all_notifications_list.dart';
import 'mentions_list.dart';

///the whole page that holds the notification bar the notification's list and the mentions list
class NotificationsPage extends StatelessWidget {
  ///setting up default credentails for each user: page should have available the user credentials
  String username = 'Default user';
  String token = '';
  bool isAdmin = false;

  ///constructor to set the user credentials
  NotificationsPage(this.username, this.token, this.isAdmin);
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
            body: TabBarView(
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
          onPressed: () => startAddTweet(context, MY_IP_ADDRESS, "3000"),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
