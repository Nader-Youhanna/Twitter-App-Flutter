import 'package:flutter/material.dart';
import './confirm_email.dart';

class SignUp extends StatefulWidget {
  static const _widthOfTextFields = 320.0;
  var _emailIsValid = false;

  bool isEmailValid(var email) {
    return (_emailIsValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email));
  }

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _mailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _usernameKey = GlobalKey<FormState>();

  var _allIsEntered = false;
  var _usernameIsEntered = false;
  var _emailIsEntered = false;
  var _dobIsEntered = false;
  var _nameIsEntered = false;
  var _usernameIsValid = false;
  var _passwordIsValid = false;
  var _username;
  var _email;
  var _dob = null;
  var _name;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _goToConfirmEmail(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ConfirmEmail(
          name: _name,
          username: _username,
          email: _email,
          dob: '${_dob.year}-${_dob.month}-${_dob.day}',
        );
      }),
    );
  }

  bool _isUserNameValid(var name) {
    return (_usernameIsValid = !RegExp(r"^nader$").hasMatch(name));
  }

  Future _pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 05, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    setState(() {
      _dobIsEntered = true;
      if (_nameIsEntered &&
          _emailIsEntered &&
          widget._emailIsValid &&
          _usernameIsEntered &&
          _usernameIsValid) {
        _allIsEntered = true;
      }
      _dob = newDate;
    });
  }

  String _getDate() {
    if (_dob == null) {
      return 'Date of Birth';
    } else {
      return '${_dob.month}/${_dob.day}/${_dob.year}';
    }
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

                //New logo
                const SizedBox(
                  width: 70,
                ),
                const Text(
                  'Sirius',
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RalewayMedium',
                  ),
                ),

                //Old logo
                // const SizedBox(
                //   width: 60,
                // ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(18),
                //   child: Image.asset(
                //     'assets/images/logo_icon.png',
                //     width: 120,
                //     height: 50,
                //     fit: BoxFit.fill,
                //   ),
                // ),
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
            Column(
              children: <Widget>[
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _name = value;
                        setState(() {
                          _nameIsEntered = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                      suffixIcon: (_nameIsEntered)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : (_usernameIsEntered && !_usernameIsValid)
                              ? const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                )
                              : null,
                    ),
                  ),
                ),
                Form(
                  key: _usernameKey,
                  child: SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(
                          () {
                            _usernameIsEntered = value.isNotEmpty;
                            if (_usernameKey.currentState!.validate()) {
                              _username = value;
                            }
                          },
                        );
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (_usernameIsValid && _usernameIsEntered)
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_usernameIsEntered && !_usernameIsValid)
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      validator: (value) {
                        if (value != null && _isUserNameValid(value)) {
                          return null;
                        } else {
                          return 'This username is already taken';
                        }
                      },
                    ),
                  ),
                ),
                Form(
                  key: _mailKey,
                  child: SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (widget._emailIsValid && _emailIsEntered)
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_emailIsEntered && !widget._emailIsValid)
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _emailIsEntered = value.isNotEmpty;
                          if (value.isNotEmpty) {
                            _emailIsEntered = true;
                            _email = value;
                            if (_nameIsEntered &&
                                _usernameIsEntered &&
                                _dobIsEntered) {
                              _allIsEntered = true;
                            }
                          } else {
                            _emailIsEntered = false;
                          }
                          if (_mailKey.currentState!.validate()) {
                            _email = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value != null && widget.isEmailValid(value)) {
                          return null;
                        } else {
                          return 'Please enter a valid email address';
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: InkWell(
                    onTap: () {
                      _pickDate(context);
                    },
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 17),
                        Row(
                          children: <Widget>[
                            Text(
                              (_dob == null)
                                  ? 'Date of birth'
                                  : '${_dob.month}/${_dob.day}/${_dob.year}',
                              style: TextStyle(
                                fontFamily: 'RalewayMedium',
                                fontSize: 16,
                                color: (_dob == null)
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          height: 1,
                          thickness: 1.4,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 260),
            Row(
              children: <Widget>[
                const SizedBox(width: 280),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: (_allIsEntered)
                      ? () {
                          _goToConfirmEmail(context);
                        }
                      : () {},
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
