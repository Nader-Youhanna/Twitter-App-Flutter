import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';

///class to show list of followers
class Followers_page extends StatefulWidget {
  final List<User_Item> Users_List;
  Followers_page(this.Users_List);
  @override
  State<Followers_page> createState() => _Followers_pageState();
}

class _Followers_pageState extends State<Followers_page> {
  final appBarHeight = 100.0;
  final bottomNavigationBarHeight = 100.0;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return widget.Users_List[index];
        },
        itemCount: widget.Users_List.length,
      ),
    );
  }
}
