import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';

class DialPadKey extends StatefulWidget {
  DialPadKey({Key key, this.onPressed, this.digit, this.alphas})
      : super(key: key);

  final Function(String) onPressed;
  final digit;
  final alphas;

  @override
  State<StatefulWidget> createState() => _DialPadKeyState();
}

class _DialPadKeyState extends State<DialPadKey> {
  var digitStyling = TextStyle(color: Colors.white, fontSize: 36.0, height: 1.0);
  var alphaStyling = TextStyle(color: smoke, height: 1.0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RawMaterialButton(
            shape: CircleBorder(),
            onPressed: () {
              widget.onPressed(widget.digit);
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.digit, style: digitStyling),
                  Text(widget.alphas, style: alphaStyling)
                ])));
  }
}
