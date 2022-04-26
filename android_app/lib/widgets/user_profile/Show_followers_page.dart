import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
import 'package:android_app/widgets/user_profile/followers_List_scroll.dart';

///class that shows the followers & following accounts of the user
class Accounts_page extends StatefulWidget {
  const Accounts_page({Key? key}) : super(key: key);

  @override
  State<Accounts_page> createState() => _Accounts_pageState();
}

class _Accounts_pageState extends State<Accounts_page> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    var _tabs = ["Followers", "Following"];

    List<User_Item> User_item = [
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", false, true, "bio"),
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", false, true, "bio"),
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", true, false, "bio"),
      User_Item("username", "handle", true, false, "bio"),
    ];

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          tabBarTheme: TabBarTheme(labelColor: Colors.black)),
      home: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "username",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                _goBack(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                color: Colors.black,
                onPressed: () {},
                icon: Icon(Icons.search),
                tooltip: 'search button',
              )
            ],
            bottom: TabBar(
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
            ),
          ),
          body: TabBarView(
              children: [Followers_page(User_item), Followers_page(User_item)]),
        ),
      ),
    );
  }
}
