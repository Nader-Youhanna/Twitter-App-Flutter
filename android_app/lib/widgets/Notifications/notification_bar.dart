import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:android_app/widgets/user_profile/profile.dart';

import '../Settings/settings_main.dart';

///class to create the notification's sliding bar
class NotificationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  String name = "";
  String userName = "";
  String userImage = '';
  bool isAdmin = false;
  String email = '';
  String token = '';
  NotificationBar(
    this._scaffoldKey, {
    required this.name,
    required this.userName,
    required this.userImage,
    required this.isAdmin,
    required this.email,
    required this.token,
  });

  void _goToSettings(BuildContext ctx, String user, String email) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Settings(token, user, email);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<String> _tabs = <String>['All', 'Mentions'];
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      floating: true,
      leading: IconButton(
          // icon:
          //     const Icon(Icons.add), //should be changed to google profile icon
          icon: CircleAvatar(
            //will be removed once apis are connected
            backgroundImage: NetworkImage(userImage),
            radius: 18.0,
          ),
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          }),
      actions: [
        IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: Colors.black,
            onPressed: () => {
                  _goToSettings(context, userName, email)
                }), //button shoud direct to setings
      ],
      bottom: TabBar(
        indicatorColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.0,
        indicator: MaterialIndicator(
          color: Colors.blue,
          height: 4,
          topLeftRadius: 8,
          topRightRadius: 8,
          bottomRightRadius: 8,
          bottomLeftRadius: 8,
          // horizontalPadding: 10,
          tabPosition: TabPosition.bottom,
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
      ),
      title: const Text('Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            //fontWeight: FontWeight.bold
          )),
      elevation: 0.5,
    );
  }
}
