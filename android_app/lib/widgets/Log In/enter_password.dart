import 'package:flutter/material.dart';

class EnterPasswordPage extends StatelessWidget {
  const EnterPasswordPage({Key? key}) : super(key: key);
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    final username;
    //EnterPasswordPage(this.username);
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 35,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 29,
                ),
                onPressed: () {
                  _goBack(context);
                },
              ),
              const SizedBox(
                width: 60,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/logo_icon.png',
                  width: 120,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
