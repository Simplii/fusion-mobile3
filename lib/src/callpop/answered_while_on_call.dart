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
  AnsweredWhileOnCall({Key key, this.activeCall, this.softphone, this.calls})
      : super(key: key);

  final Softphone softphone;
  final List<Call> calls;
  final Call activeCall;

  @override
  State<StatefulWidget> createState() => _AnsweredWhileOnCallState();
}

class _AnsweredWhileOnCallState extends State<AnsweredWhileOnCall> {
  List<Call> get calls => widget.calls;

  Call get activeCall => widget.activeCall;

  Softphone get softphone => widget.softphone;

  switchGestureDetector(Widget child, call) {
    return GestureDetector(
        onTap: () {
          softphone.makeActiveCall(call);
        },
        child: Container(decoration: clearBg(), child: child));
  }

  _callRow(Call call) {
    CallpopInfo info = softphone.getCallpopInfo(call.id);
    TextStyle textStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
    bool isMerged = softphone.isCallMerged(call);

    return Row(children: [
      switchGestureDetector(
          ContactCircle.withDiameterAndMargin(info != null ? info.contacts : [],
              info != null ? info.crmContacts : [], 24, 8),
          call),
      switchGestureDetector(
          Text(softphone.getCallerName(call), style: textStyle), call),
      Expanded(child: switchGestureDetector(Container(), call)),
      if (softphone.getHoldState(call))
        switchGestureDetector(Text("Hold", style: textStyle), call),
      Text(" " + mDash + " " + softphone.getCallRunTimeString(call),
          style: textStyle),
      if (!isMerged)
        GestureDetector(
            onTap: () {
              softphone.mergeCalls(activeCall, call);
            },
            child: Container(
                decoration: clearBg(),
                padding: EdgeInsets.only(left: 12, top: 2, bottom: 2),
                child: Image.asset("assets/icons/call_view/merge.png",
                    width: 20, height: 20))),
    ]);
  }

  _hangupButton(call) {
    return GestureDetector(
      onTap: () {
        widget.softphone.hangUp(call);
      },
      child: Center(
          child: Container(
              decoration: raisedButtonBorder(crimsonLight,
                  darkenAmount: 40, lightenAmount: 60),
              padding: EdgeInsets.all(1),
              child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: crimsonLight),
                  child: Image.asset("assets/icons/phone.png",
                      width: 14, height: 14)))),
    );
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
