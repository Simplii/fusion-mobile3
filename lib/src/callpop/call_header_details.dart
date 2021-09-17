import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallHeaderDetails extends StatefulWidget {
  CallHeaderDetails(
      {Key key, this.callerName, this.callerOrigin, this.callRunTime})
      : super(key: key);

  final callerName;
  final callerOrigin;
  final callRunTime;

  @override
  State<StatefulWidget> createState() => _CallHeaderDetailsState();
}

class _CallHeaderDetailsState extends State<CallHeaderDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(widget.callerName,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  Icon(
                    CupertinoIcons.pencil,
                    color: Colors.grey,
                  )
                ]),
                Text(widget.callerOrigin,
                    style: TextStyle(fontSize: 14, color: Colors.white))
              ])),
          Text(widget.callRunTime,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
