import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class UserReports extends StatefulWidget {
  const UserReports({Key? key}) : super(key: key);

  @override
  State<UserReports> createState() => _UserReportsState();
}

class _UserReportsState extends State<UserReports> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: const Text(
              "User Reports",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                //Icons.abc,
                color: Colors.black,
              ),
              onPressed: () {
                _goBack(context);
              },
            )),
        body: SingleChildScrollView(
          child: Column(children: []),
        ),
      ),
    );
  }
}
