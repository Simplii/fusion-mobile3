import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_buttons.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_dialpad.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_footer_details.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_header_details.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:sip_ua/sip_ua.dart';

class CallView extends StatefulWidget {
  CallView(this._softphone, {Key key, this.closeView}) : super(key: key);

  final VoidCallback closeView;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  Softphone get _softphone => widget._softphone;

  Call get _activeCall => _softphone.activeCall;

  bool dialpadVisible = false;

  _onHoldBtnPress() {
    _softphone.setHold(_activeCall, true);
  }

  _onResumeBtnPress() {
    _softphone.setHold(_activeCall, false);
  }

  _onXferBtnPress() {}

  _onDialBtnPress() {
    setState(() {
      dialpadVisible = !dialpadVisible;
    });
  }

  _onParkBtnPress() {}

  _onConfBtnPress() {}

  _onRecBtnPress() {}

  _onVidBtnPress() {}

  _onTextBtnPress() {}

  _onAudioBtnPress() {}

  _onHangup() {
    _softphone.hangUp(_activeCall);
    widget.closeView();
  }

  _onHoldView() {
    return Expanded(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('On hold'),
          GestureDetector(
              onTap: _onResumeBtnPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: translucentWhite(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.play_arrow_solid,
                            color: Colors.white, size: 16.0),
                        Text('Resume')
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var callerName = _softphone.getCallerName(_activeCall);
    var callerOrigin =
        _softphone.getCallerNumber(_activeCall); // 'mobile' | 'work' ...etc
    var callRunTime = _softphone.getCallRunTime(
        _activeCall); // get call start time and calculate duration

    Map<String, Function()> actions = {
      'onHoldBtnPress': _onHoldBtnPress,
      'onXferBtnPress': _onXferBtnPress,
      'onDialBtnPress': _onDialBtnPress,
      'onParkBtnPress': _onParkBtnPress,
      'onConfBtnPress': _onConfBtnPress,
      'onRecBtnPress': _onRecBtnPress,
      'onVidBtnPress': _onVidBtnPress,
      'onTextBtnPress': _onTextBtnPress,
      'onAudioBtnPress': _onAudioBtnPress,
      'onHangup': _onHangup,
    };

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              if (_softphone.getHoldState(_activeCall))
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF000000), Color(0x1affffff)],
                )),
              )),
              SafeArea(
                  bottom: false,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CallHeaderDetails(
                            callerName: callerName,
                            callerOrigin: callerOrigin,
                            callRunTime: callRunTime),
                        if (_softphone.getHoldState(_activeCall))
                          _onHoldView()
                        else
                          Spacer(),
                        if (!_softphone.getHoldState(_activeCall) &&
                            dialpadVisible)
                          CallDialPad(),
                        CallActionButtons(
                            actions: actions,
                            callOnHold: _softphone.getHoldState(_activeCall)),
                        CallFooterDetails()
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
