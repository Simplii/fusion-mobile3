import 'dart:async';
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
  Timer _timer;

  initState() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        setState(() {});
      },
    );
  }

  @override
  dispose() {
    _timer.cancel();
    super.dispose();
  }

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
          Text('ON HOLD',
              style: TextStyle(
                  color: translucentWhite(0.67),
                  fontSize: 12,
                  height: 1.4,
                  fontWeight: FontWeight.w700)),
          GestureDetector(
              onTap: _onResumeBtnPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: 12, left: 16, right: 16, bottom: 12),
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: translucentWhite(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Image.asset(
                                "assets/icons/call_view/play.png",
                                width: 12,
                                height: 16)),
                        Text('RESUME',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.2))
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
    var companyName = _softphone.getCallerCompany(_activeCall);
    var callerName = _softphone.getCallerName(_activeCall);
    var callerOrigin =
        _softphone.getCallerNumber(_activeCall); // 'mobile' | 'work' ...etc
    var duration = _softphone.getCallRunTime(
        _activeCall); // get call start time and calculate duration
    String callRunTime = "";
    if (duration < 60) {
      callRunTime =
          "00:" + (duration % 60 < 10 ? "0" : "") + duration.toString();
    } else if (duration < 60 * 60) {
      callRunTime = ((duration / 60).floor() < 10 ? "0" : "") +
          (duration / 60).floor().toString() +
          ":" +
          (duration % 60 < 10 ? "0" : "") +
          (duration % 60).toString();
    } else {
      int hours = (duration / (60 * 60)).floor();
      duration = duration - hours;
      callRunTime = (hours < 10 ? "0" : "") +
          hours.toString() +
          ":" +
          ((duration / 60).floor() < 10 ? "0" : "") +
          (duration / 60).floor().toString() +
          ":" +
          (duration % 60 < 10 ? "0" : "") +
          (duration % 60).toString();
    }

    Map<String, Function()> actions = {
      'onHoldBtnPress': _onHoldBtnPress,
      'onResumeBtnPress': _onResumeBtnPress,
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
              if (_softphone.getHoldState(_activeCall) || dialpadVisible)
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [translucentWhite(0.0), Colors.black],
                  )),
                )),
              if (_softphone.getHoldState(_activeCall) || dialpadVisible)
                ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
                        child: Container())),
              SafeArea(
                  bottom: false,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CallHeaderDetails(
                            callerName: callerName,
                            companyName: companyName,
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
                            dialPadOpen: dialpadVisible,
                            setDialpad: (bool isOpen) {
                              setState(() {
                                print("isopen" + isOpen.toString() + dialpadVisible.toString());
                                dialpadVisible = isOpen;
                                print("isopen" + isOpen.toString() + dialpadVisible.toString());
                              });
                            },
                            callOnHold: _softphone.getHoldState(_activeCall)),
                        CallFooterDetails(_softphone, _activeCall)
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
