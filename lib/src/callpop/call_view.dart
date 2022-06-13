import 'dart:async';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_buttons.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_dialpad.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_footer_details.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_header_details.dart';
import 'package:fusion_mobile_revamped/src/callpop/incoming_while_on_call.dart';
import 'package:fusion_mobile_revamped/src/callpop/transfer_call_popup.dart';
import 'package:fusion_mobile_revamped/src/components/popup_menu.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad_modal.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:sip_ua/sip_ua.dart';

import 'answered_while_on_call.dart';

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
  List<Call> get _allCalls => _softphone.calls;

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
    _softphone.setHold(_activeCall, true,  true);
  }

  _onResumeBtnPress() {
    if (!_softphone.isCellPhoneCallActive)
      _softphone.setHold(_activeCall, false, true);
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
            TransferCallPopup(_fusionConnection, _softphone, () {
              Navigator.pop(context);
            }, (String xferTo, String xferType) {
              if (xferType == "blind") {
                _softphone.transfer(_activeCall, _makeXferUrl(xferTo));
                print("xferrred" +
                    ":" +
                    _makeXferUrl(xferTo) +
                    ":" +
                    _activeCall.toString());
              }
              Navigator.pop(context);
            }));
  }

  _onDialBtnPress() {
    if (_softphone.getHoldState(_activeCall)) {
      setState(() {
        dialpadVisible = false;
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => DialPadModal(_fusionConnection, _softphone));
      });
    } else {
      setState(() {
        dialpadVisible = !dialpadVisible;
      });
    }
  }

  _onParkBtnPress() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            DialPadModal(_fusionConnection, _softphone, initialTab: 0));
  }

  _onConfBtnPress() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => DialPadModal(_fusionConnection, _softphone));
  }

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
    var callPopInfo = _softphone.getCallpopInfo(_activeCall.id);
    SMSConversationView.openConversation(
        context,
        _fusionConnection,
        callPopInfo != null ? callPopInfo.contacts : [],
        callPopInfo != null ? callPopInfo.crmContacts: [],
        _softphone,
        callPopInfo != null
            ? callPopInfo.phoneNumber
            : _softphone.getCallerNumber(_softphone.activeCall));
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
                            print("setting output from gesture");
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

  _onMuteBtnPress() {
    _softphone.setMute(_activeCall, !_softphone.getMuted(_activeCall));
  }

  _onHangup() {
    _softphone.hangUp(_activeCall);
    widget.closeView();
  }

  _onAnswer() {
    _softphone.answerCall(_activeCall);
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
                        if (!_softphone.isCellPhoneCallActive)
                        Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Image.asset(
                                "assets/icons/call_view/play.png",
                                width: 12,
                                height: 16)),
                        Text(_softphone.isCellPhoneCallActive ? 'Mobile Call Active' : 'RESUME',
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
    var callerNumber =
        _softphone.getCallerNumber(_activeCall); // 'mobile' | 'work' ...etc

    Map<String, Function()> actions = {
      'onHoldBtnPress': _onHoldBtnPress,
      'onResumeBtnPress': _onResumeBtnPress,
      'onXferBtnPress': _onXferBtnPress,
      'onDialBtnPress': _onDialBtnPress,
      'onParkBtnPress': _onParkBtnPress,
      'onConfBtnPress': _onConfBtnPress,
      'onRecBtnPress': _onRecBtnPress,
      'onVidBtnPress': _onVidBtnPress,
      'onMuteBtnPress': _onMuteBtnPress,
      'onTextBtnPress': _onTextBtnPress,
      'onAudioBtnPress': _onAudioBtnPress,
      'onHangup': _onHangup,
      'onAnswer': _onAnswer,
    };

    String callRunTime = _softphone.getCallRunTimeString(_activeCall);

    bool isIncoming = _softphone.isIncoming(_activeCall);
    bool isRinging = !_softphone.isConnected(_activeCall);

    Call incomingCall = null;
    List<Call> connectedCalls = [];

    for (Call c in _allCalls) {
      if (c != _activeCall && !_softphone.isConnected(c))
        incomingCall = c;
      else if (c != _activeCall) connectedCalls.add(c);
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
        child: Container(
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
                        if (Platform.isIOS && isIncoming && isRinging)
                          CallActionButtons(
                              actions: actions,
                              isRinging: isRinging,
                              isIncoming: isIncoming,
                              dialPadOpen: dialpadVisible,
                              resumeDisabled: _softphone.isCellPhoneCallActive,
                              isOnConference:
                              _softphone.isCallMerged(_activeCall),
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
                        CallHeaderDetails(
                            callerName: callerName,
                            companyName: companyName,
                            callerNumber: callerNumber,
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
                          CallDialPad(_softphone, _activeCall),
                        if (!Platform.isIOS || !isIncoming || !isRinging)
                          CallActionButtons(
                              actions: actions,
                              isRinging: isRinging,
                              isIncoming: isIncoming,
                              dialPadOpen: dialpadVisible,
                              isOnConference:
                              _softphone.isCallMerged(_activeCall),
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
                        CallFooterDetails(
                            _fusionConnection, _softphone, _activeCall)
                      ],
                    ),
                  )),
              if (connectedCalls.length > 0)
                AnsweredWhileOnCall(
                    calls: connectedCalls,
                    softphone: _softphone,
                    activeCall: _activeCall),
              if (incomingCall != null)
                IncomingWhileOnCall(call: incomingCall, softphone: _softphone)
            ],
          ),
        ))
    );
  }
}
