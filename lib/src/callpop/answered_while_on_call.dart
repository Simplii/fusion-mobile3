import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_button.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:sip_ua/sip_ua.dart';

enum Views { Main, DialPad, Hold }

class AnsweredWhileOnCall extends StatefulWidget {
  AnsweredWhileOnCall({Key key, this.softphone, this.calls}) : super(key: key);

  final Softphone softphone;
  final List<Call> calls;

  @override
  State<StatefulWidget> createState() => _AnsweredWhileOnCallState();
}

class _AnsweredWhileOnCallState extends State<AnsweredWhileOnCall> {
  List<Call> get calls => widget.calls;

  Softphone get softphone => widget.softphone;

  _callRow(Call call) {
    CallpopInfo info = softphone.getCallpopInfo(call.id);
    return GestureDetector(
        onTap: () {
          softphone.makeActiveCall(call);
        },
        child: Container(
            decoration: clearBg(),
            child: Row(children: [
              ContactCircle.withDiameterAndMargin(
                  info != null ? info.contacts : [],
                  info != null ? info.crmContacts : [],
                  24,
                  8),
              Text(softphone.getCallerName(call),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              Spacer(),
              Text("Hold " + mDash + " " + softphone.getCallRunTimeString(call),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 42 + 0 + calls.length * 36.0,
        padding: EdgeInsets.only(top: 42, bottom: 0),
        decoration: BoxDecoration(
            color: coal,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Column(
                children: calls
                    .map((Call c) => _callRow(c))
                    .toList()
                    .cast<Widget>())));
  }
}
