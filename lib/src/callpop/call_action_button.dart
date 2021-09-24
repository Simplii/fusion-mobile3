import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';

class CallActionButton extends StatefulWidget {
  CallActionButton(
      {Key key, this.onPressed, this.title, this.icon, this.disabled})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _CallActionButtonState();
}

class _CallActionButtonState extends State<CallActionButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 64,
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,
                color: widget.disabled == true ? halfGray : Colors.white),
            Text(widget.title.toUpperCase(),
                style: TextStyle(color: Color.fromARGB(127, 0, 0, 0)))
          ],
        ),
      ),
    ));
  }
}
