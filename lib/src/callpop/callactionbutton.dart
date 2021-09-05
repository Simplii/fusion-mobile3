import 'package:flutter/material.dart';

class CallActionButton extends StatefulWidget {
  CallActionButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.icon})
      : super(key: key);

  final VoidCallback onPressed;
  final title;
  final icon;

  @override
  State<StatefulWidget> createState() => _CallActionButtonState();
}

class _CallActionButtonState extends State<CallActionButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Column(
        children: [Icon(widget.icon), Text(widget.title)],
      ),
    );
  }
}
