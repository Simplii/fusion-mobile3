import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class CallHeaderDetails extends StatefulWidget {
  CallHeaderDetails(
      {Key key, this.callerName, this.callerOrigin, this.callRunTime, this.companyName})
      : super(key: key);

  final callerName;
  final companyName;
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
              padding: EdgeInsets.only(left: 16.0, right: 16, top: 24, bottom: 16),
              child: Column(children: [
                Text(widget.companyName != "" ? widget.companyName : "asdf",
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.4,
                          color: translucentWhite(0.67),
                          fontWeight: FontWeight.w600)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(widget.callerName,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  Container(width: 12),
                  Image.asset(
                    "assets/icons/call_view/edit.png",
                        width: 20, height: 20
                  )
                ]),
                Text(widget.callerOrigin,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: translucentWhite(0.67)))
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
