import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:android_app/widgets/user_profile/profile.dart';

///class to create the notification's sliding bar
class NotificationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  NotificationBar(this._scaffoldKey);

  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 12.0,
  ); //should be fetched in the constructor
  @override
  Widget build(BuildContext context) {
    const List<String> _tabs = <String>['All', 'Mentions'];
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      floating: true,
      leading: IconButton(
        icon: const Icon(
            Icons.person_rounded), //should be changed to google profile icon
        color: Colors.black,
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        //button should open to side bar
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: Colors.black,
            onPressed: () => {}), //button shoud direct to setings
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
