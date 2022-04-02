import 'package:flutter/material.dart';

class Follow_button extends StatefulWidget {
  bool _alreadyfollowed;
  Follow_button(this._alreadyfollowed);

  @override
  State<Follow_button> createState() => _Follow_buttonState();
}

class _Follow_buttonState extends State<Follow_button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget._alreadyfollowed ? Colors.white : Colors.black,
        shape: StadiumBorder(),
        shadowColor: Colors.black,
        side: BorderSide(width: 1, color: Color.fromARGB(255, 68, 68, 68)),
        minimumSize: Size(100, 30),
      ),
      child: Text(
        (widget._alreadyfollowed ? 'unFollow' : 'Follow'),
        style: TextStyle(
          fontSize: 14,
          color: widget._alreadyfollowed ? Colors.black : Colors.white,
        ),
      ),
      onPressed: () {
        setState(() {
          widget._alreadyfollowed = !widget._alreadyfollowed;
        });
      },
    );
  }
}
