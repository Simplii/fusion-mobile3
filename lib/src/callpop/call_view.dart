import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_buttons.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_dialpad.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_footer_details.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_header_details.dart';
import 'package:fusion_mobile_revamped/src/callpop/transfer_call_popup.dart';
import 'package:fusion_mobile_revamped/src/components/popup_menu.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:sip_ua/sip_ua.dart';

class CallView extends StatefulWidget {
  CallView(this._fusionConnection, this._softphone, {Key key, this.closeView})
      : super(key: key);

  final VoidCallback closeView;
  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  Softphone get _softphone => widget._softphone;

  FusionConnection get _fusionConnection => widget._fusionConnection;

  Call get _activeCall => _softphone.activeCall;

  bool dialpadVisible = false;
  Timer _timer;

  initState() {
    super.initState();
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

  _makeXferUrl(String url) {
    if (url.contains("@"))
      return 'sip:' + url;
    else
      return url;
  }

  _onXferBtnPress() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) =>
            TransferCallPopup(
                _fusionConnection, _softphone,
                    () {
                      Navigator.pop(context);
                    },
                    (String xferTo, String xferType) {
                      if (xferType == "blind") {
                        _softphone.transfer(_activeCall, _makeXferUrl(xferTo));
                        print("xferrred" + ":" + _makeXferUrl(xferTo) + ":" + _activeCall.toString());
                      }
                      Navigator.pop(context);
                    }));
  }

  _onDialBtnPress() {
    setState(() {
      dialpadVisible = !dialpadVisible;
    });
  }

  _onParkBtnPress() {
    _fusionConnection.nsApiCall("call", "park", {
      "uid": _fusionConnection.getUid(),
      "callid": _activeCall.id
    }, callback: (Map<String, dynamic> respone) {
      print("response" + respone.toString());
    });
  }

  _onConfBtnPress() {}

  _onRecBtnPress() {
    print("recbtnpress");
    if (_softphone.getRecordState(_activeCall)) {
      _softphone.stopRecordCall(_activeCall);
    } else {
      _softphone.recordCall(_activeCall);
    }
  }

  _onVidBtnPress() {}

  _onTextBtnPress() {
    SMSConversationView.openConversation(
        context,
        _fusionConnection,
        _softphone.getCallpopInfo(_activeCall.id).contacts,
        _softphone.getCallpopInfo(_activeCall.id).crmContacts,
        _softphone,
        _softphone.getCallpopInfo(_activeCall.id).phoneNumber);
  }

  _onAudioBtnPress() {
    List<List<String>> options = [
      ["assets/icons/call_view/audio_phone.png", "Phone", "phone"],
      ["assets/icons/call_view/audio_speaker.png", "Speaker", "speaker"],
    ];
    String callAudioOutput = _softphone.getCallOutput(_activeCall);
    bool muted = _softphone.getMuted(_activeCall);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: "AUDIO SOURCE",
            topChild: Row(children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        _softphone.setMute(_activeCall, !muted);
                        Navigator.pop(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              bottom: 24, left: 20, right: 20, top: 6),
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          decoration: BoxDecoration(
                              color: muted ? crimsonDarker : coal,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                    color: translucentBlack(0.28),
                                    offset: Offset.zero,
                                    blurRadius: 36)
                              ]),
                          child: Text(muted ? "Muted" : "Mute",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                height: 1.4,
                              )))))
            ]),
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 24,
                    maxHeight: 100,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width - 136),
                child: ListView(
                    padding: EdgeInsets.all(8),
                    children: options.map((List<String> option) {
                      return GestureDetector(
                          onTap: () {
                            _softphone.setCallOutput(_activeCall, option[2]);
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 18, right: 18),
                              decoration: BoxDecoration(
                                  color: option[2] == callAudioOutput
                                      ? lightHighlight
                                      : Colors.transparent,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightDivider, width: 1.0))),
                              child: Row(children: [
                                Image.asset(option[0], width: 15, height: 15),
                                Container(width: 12),
                                Text(option[1],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                Spacer(),
                                if (callAudioOutput == option[2])
                                  Image.asset(
                                      "assets/icons/call_view/check.png",
                                      width: 16,
                                      height: 11)
                              ])));
                    }).toList()))));
  }

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

    bool isIncoming = _softphone.isIncoming(_activeCall);
    bool isRinging = !_softphone.isConnected(_activeCall);

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              if (_softphone.getHoldState(_activeCall) || dialpadVisible)
                Container(
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
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CallHeaderDetails(
                            callerName: callerName,
                            companyName: companyName,
                            callerOrigin: callerOrigin,
                            isRinging: isRinging,
                            callIsRecording:
                                _softphone.getRecordState(_activeCall),
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
                            isRinging: isRinging,
                            isIncoming: isIncoming,
                            dialPadOpen: dialpadVisible,
                            setDialpad: (bool isOpen) {
                              setState(() {
                                print("isopen" +
                                    isOpen.toString() +
                                    dialpadVisible.toString());
                                dialpadVisible = isOpen;
                                print("isopen" +
                                    isOpen.toString() +
                                    dialpadVisible.toString());
                              });
                            },
                            callIsRecording:
                                _softphone.getRecordState(_activeCall),
                            callIsMuted: _softphone.getMuted(_activeCall),
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
