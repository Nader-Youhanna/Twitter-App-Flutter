import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'admin_view_main.dart';
import 'package:flutter/material.dart';
import 'test.dart';

class StatisticsCard extends StatelessWidget {
  String title, value, percentage;
  bool increase;

  StatisticsCard(
      {required this.title,
      required this.value,
      required this.percentage,
      required this.increase});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 15),
          Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminViewMain(selectedIndex: 1),
                        ),
                      );
                    },
                  text: 'See all Users',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'RalewayMedium',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                '^ $percentage%',
                style: TextStyle(
                  color: increase ? Colors.green : Colors.red,
                  fontFamily: 'RalewayMedium',
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.person,
                size: 27,
                color: Colors.grey.shade700,
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
      elevation: 10,
    );
  }
}
