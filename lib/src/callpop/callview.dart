import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/callactionbuttons.dart';
import 'package:fusion_mobile_revamped/src/callpop/calldialpad.dart';
import 'package:fusion_mobile_revamped/src/callpop/callfooterdetails.dart';
import 'package:fusion_mobile_revamped/src/callpop/callheaderdetails.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad.dart';

class CallView extends StatefulWidget {
  CallView({Key key, this.closeView}) : super(key: key);

  final VoidCallback closeView;

  @override
  State<StatefulWidget> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  var callerName = 'Unknown';
  var callerOrigin = '801-345-9792'; // 'mobile' | 'work' ...etc
  var callRunTime = '00:37'; // get call start time and calculate duration
  bool dialpadVisible = false;

  onHoldBtnPress() {}

  onXferBtnPress() {}

  onDialBtnPress() {
    setState(() {
      dialpadVisible = true;
    });
  }

  onParkBtnPress() {}

  onConfBtnPress() {}

  onRecBtnPress() {}

  onVidBtnPress() {}

  onTextBtnPress() {}

  onAudioBtnPress() {}

  onHangup() {
    widget.closeView();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Function()> actions = {
      'onHoldBtnPress': onHoldBtnPress,
      'onXferBtnPress': onXferBtnPress,
      'onDialBtnPress': onDialBtnPress,
      'onParkBtnPress': onParkBtnPress,
      'onConfBtnPress': onConfBtnPress,
      'onRecBtnPress': onRecBtnPress,
      'onVidBtnPress': onVidBtnPress,
      'onTextBtnPress': onTextBtnPress,
      'onAudioBtnPress': onAudioBtnPress,
      'onHangup': onHangup,
    };

    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CallHeaderDetails(
              callerName: callerName,
              callerOrigin: callerOrigin,
              callRunTime: callRunTime),
          Spacer(),
          if (dialpadVisible) CallDialPad(),
          CallActionButtons(actions: actions),
          CallFooterDetails()
        ],
      ),
    );
  }
}
