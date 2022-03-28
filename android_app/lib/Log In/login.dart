import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 35,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_back,
                size: 29,
              ),
              const SizedBox(
                width: 80,
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
          const SizedBox(height: 30),
          const SizedBox(
            width: 320,
            child: Text(
              'To get started, first enter your phone, email, or @username',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'RalewayMedium',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 330,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Phone, email or username',
              ),
              controller: emailController,
            ),
          ),
          const SizedBox(height: 400),
          Row(
            children: <Widget>[
              const SizedBox(width: 12),
              ElevatedButton(
                child: const Text(
                  'Forgot Password?',
                ),
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<StadiumBorder>(
                    const StadiumBorder(
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 125),
              ElevatedButton(
                child: const Text('Next'),
                onPressed: () {},
                style: (emailController.text.isEmpty)
                    ? ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade400),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade600),
                        shape: MaterialStateProperty.all<StadiumBorder>(
                          const StadiumBorder(),
                        ),
                      )
                    : ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
