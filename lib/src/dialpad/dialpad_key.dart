import 'package:flutter/material.dart';

class DialPadKey extends StatefulWidget {
  DialPadKey({Key key, this.onPressed, this.digit, this.alphas})
      : super(key: key);

  final VoidCallback onPressed;
  final digit;
  final alphas;

  @override
  State<StatefulWidget> createState() => _DialPadKeyState();
}

class _DialPadKeyState extends State<DialPadKey> {
  var digitStyling = TextStyle(color: Colors.white, fontSize: 36.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: widget.onPressed,
          child: Column(children: [
            Text(widget.digit, style: digitStyling),
            Text(widget.alphas)
          ]))
    );
  }
}
