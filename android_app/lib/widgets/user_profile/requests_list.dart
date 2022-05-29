import 'package:android_app/widgets/user_profile/followRequestItem.dart';
import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/users_list_item.dart';
import 'package:android_app/widgets/user_profile/FollowRequests.dart';

///class to show list of followers
class RequestsPage extends StatefulWidget {
  final List<RequestsItem> Users_List;
  RequestsPage(this.Users_List);
  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
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
