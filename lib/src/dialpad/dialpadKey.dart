import 'package:flutter/material.dart';

class DialPadKey extends StatefulWidget {
  DialPadKey({Key key, this.onPressed, this.digit}) : super(key: key);

  final VoidCallback onPressed;
  final digit;

  @override
  State<StatefulWidget> createState() => _DialPadKeyState();
}

class _DialPadKeyState extends State<DialPadKey> {
  var digitStyling = TextStyle(color: Colors.white, fontSize: 36.0);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        child: Center(child: Text(widget.digit, style: digitStyling)));
  }
}
