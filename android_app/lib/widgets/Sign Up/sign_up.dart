import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SignUp extends StatefulWidget {
  static const _widthOfTextFields = 320.0;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _allIsEntered = false;
  var _nameIsEntered = false;
  var _name;
  var _emailIsEntered = false;
  var _emailIsValid = false;
  var _email;
  var _dobIsEntered = false;
  var _dob;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  bool _isEmailValid(var email) {
    return (_emailIsValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(height: 30),
            const SizedBox(
              width: 320,
              child: Text(
                'Create your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: _nameIsEntered
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nameIsEntered = value.isNotEmpty;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            _nameIsEntered = true;
                            _name = value;
                            if (_emailIsEntered && _dobIsEntered) {
                              _allIsEntered = true;
                            }
                          } else {
                            _nameIsEntered = false;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Phone number or email address',
                        suffixIcon: (_emailIsValid && _emailIsEntered)
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_emailIsEntered && !_emailIsValid)
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            _emailIsEntered = value.isNotEmpty;
                            if (value.isNotEmpty) {
                              _emailIsEntered = true;
                              _email = value;
                              if (_nameIsEntered && _dobIsEntered) {
                                _allIsEntered = true;
                              }
                            } else {
                              _emailIsEntered = false;
                            }
                          });
                          if (_formKey.currentState!.validate()) {
                            _email = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value != null && _isEmailValid(value)) {
                          return null;
                        } else {
                          return 'Please enter a valid email address';
                        }
                      },
                      // onSubmitted: (value) {
                      //   if (value.isNotEmpty) {
                      //     setState(() {
                      //       if (value.isNotEmpty) {
                      //         _emailIsEntered = true;
                      //         email = value;
                      //         if (_nameIsEntered && _dobIsEntered) {
                      //           _allIsEntered = true;
                      //         }
                      //       } else {
                      //         _emailIsEntered = false;
                      //       }
                      //     });
                      //   }
                      // },
                    ),
                  ),
                  SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'Date of birth',
                        suffixIcon: _dobIsEntered
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _dobIsEntered = value.isNotEmpty;
                        });
                      },
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        ).then((value) {
                          setState(() {
                            if (value != null) {
                              _dobIsEntered = true;
                              _dob = value;
                              if (_nameIsEntered &&
                                  _emailIsEntered &&
                                  _emailIsValid) {
                                _allIsEntered = true;
                              }
                            } else {
                              _dobIsEntered = false;
                            }
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 290),
            Row(
              children: <Widget>[
                const SizedBox(width: 280),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {},
                  style: (!_allIsEntered)
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
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(),
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
