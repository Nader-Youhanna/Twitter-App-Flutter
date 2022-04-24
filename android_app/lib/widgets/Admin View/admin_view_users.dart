import 'package:flutter/material.dart';
import 'admin_view_user.dart';

class AdminViewUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          AdminViewUser('Nader', 'nido7'),
          AdminViewUser('Ahmed', 'ahmedMoh123'),
        ],
      ),
    );
  }
}
