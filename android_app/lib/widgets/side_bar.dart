import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Settings/settings_main.dart';
import './Messages/inbox.dart';
import 'Admin View/admin_view_main.dart';
import 'user_profile/profile.dart';
import 'Notifications/notifications_page.dart';

///This is the Sidebar that opens when you swipe or click the left corner icon
class SideBar extends StatelessWidget {
  final name, username;
  final isAdmin = true;
  final token = '';
  @override
  SideBar({
    @required this.name,
    @required this.username,
    //@required this.token,
    //@required this.isAdmin,
  });

  ///This is a navigation function that redirects to login page
  void _goToUserProfile(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Profile(username, 1, false);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {
              _goToUserProfile(context);
            },
            accountName: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              '@' + username,
            ),
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
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 27,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToUserProfile(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              size: 27,
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) {
                  return NotificationsPage(
                    username,
                    token,
                    isAdmin,
                  );
                }),
              );
            },
          ),
          const ListTile(
            leading: Icon(
              Icons.bookmark,
              size: 27,
            ),
            title: Text(
              'Bookmarks',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.mail,
              size: 27,
            ),
            title: const Text(
              'Inbox',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) {
                  return Inbox(
                    username: username,
                    token: token,
                  );
                }),
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return Settings();
                  },
                ),
              );
            },
            leading: const Icon(
              Icons.settings,
              size: 27,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.description,
              size: 27,
            ),
            title: Text(
              'Policies',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
          ),
          Visibility(
            visible: isAdmin,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return AdminViewMain();
                    },
                  ),
                );
              },
              leading: const Icon(
                Icons.admin_panel_settings,
                size: 27,
              ),
              title: const Text(
                'Admin View',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'RalewayMedium',
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            leading: const Icon(
              Icons.logout,
              size: 27,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 27,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
