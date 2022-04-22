import 'package:flutter/material.dart';
import './terms_and_conditions.dart';

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
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  var _allIsEntered = false;
  var _nameIsEntered = false;
  var _emailIsEntered = false;
  var _dobIsEntered = false;
  var _nameIsValid = false;
  var _passwordIsValid = false;
  var _username;
  var _email;
  var _dob = null;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void _goToTermsAndConditions(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return TermsAndConditions(
          username: _username,
          email: _email,
          dob: '${_dob.day}/${_dob.month}/${_dob.year}',
        );
      }),
    );
  }

  bool _isNameValid(var name) {
    return (_nameIsValid = !RegExp(r"^nader$").hasMatch(name));
  }

  Future _pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;
    setState(() {
      _dobIsEntered = true;
      if (_emailIsEntered &&
          widget._emailIsValid &&
          _nameIsEntered &&
          _nameIsValid) {
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
                Form(
                  key: _nameKey,
                  child: SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (_nameIsValid && _nameIsEntered)
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_nameIsEntered && !_nameIsValid)
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nameIsEntered = value.isNotEmpty;
                          if (_nameKey.currentState!.validate()) {
                            _username = value;
                          }
                        });
                      },
                      validator: (value) {
                        if (value != null && _isNameValid(value)) {
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
                        labelText: 'Phone number or email address',
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
                            if (_nameIsEntered && _dobIsEntered) {
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
            const SizedBox(height: 310),
            Row(
              children: <Widget>[
                const SizedBox(width: 280),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: (_allIsEntered)
                      ? () {
                          _goToTermsAndConditions(context);
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
