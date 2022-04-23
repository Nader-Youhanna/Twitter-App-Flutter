import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final name, username;
  @override
  SideBar({
    @required this.name,
    @required this.username,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text('@' + username),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/user_icon2.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/cover_image_sidebar.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
