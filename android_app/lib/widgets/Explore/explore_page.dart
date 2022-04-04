import 'package:flutter/material.dart';
import 'package:android_app/widgets/user_profile/profile.dart';

class ExplorePage extends StatelessWidget {
  //const ExplorePage({});
  var _appBarText = 'Search Twitter';
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
            width: 290,
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(10.0),
                fillColor: Color.fromARGB(255, 224, 231, 235),
                hintStyle: const TextStyle(
                  fontSize: 14.5,
                  color: Color.fromARGB(255, 100, 99, 99),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
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
      body: const Center(
          child: Text('Explore Page',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold))),
    );
  }
}
