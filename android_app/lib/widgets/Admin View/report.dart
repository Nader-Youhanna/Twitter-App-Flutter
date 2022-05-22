import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Report extends StatelessWidget {
  Report(this.username);
  CircleAvatar userImage = const CircleAvatar(
    backgroundImage: AssetImage('assets/images/user_icon2.png'),
    radius: 18.0,
  );
  String username = "@Remonda_95";
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        child: ListTile(
          leading: userImage,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: username,
                  style: TextStyle(color: Color.fromARGB(255, 130, 129, 129)),
                ),
                TextSpan(
                  text:
                      "       Reported this user!", //notification type fetched from backend
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }
}
