import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:sip_ua/src/rtc_session.dart';
import 'package:sip_ua/src/ua.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class LnSession extends RTCSession {
  LnSession(UA ua) : super(ua);
}


class LnCall extends Call {
  RTCSession _session;

  RTCSession get session => _session;
  CallStateEnum state;
  String remote_identity;
  String remote_display_name;
  String direction;

  String uuid;
  MethodChannel nativeChannel;

  LnCall(String id, RTCSession session, CallStateEnum state) : super(id, session, state);
  LnCall.makeLnCall(String callId, String remoteAddress): super(callId, LnSession(null), CallStateEnum.NONE);

  setIdentities(number, callerid, direction) {
    remote_identity = number;
    remote_display_name = callerid;
    this.direction = direction;
  }

  setChannel(channel, uuid) {
    this.uuid = uuid;
    nativeChannel = channel;
  }

  setHold(bool hold) {
    nativeChannel.invokeMethod("lpSetHold", [uuid, hold]);
  }

  hold() {
    setHold(true);
  }

  unhold() {
    setHold(false);
  }

  answer(Map<String, dynamic> s, {MediaStream mediaStream = null}) {
    print("answer call here");
    print(uuid);
    nativeChannel.invokeMethod("lpAnswer", [uuid]);
  }
  hangup([Map<String, dynamic> x = null]) {
    nativeChannel.invokeMethod("lpEndCall", [uuid]);
  }

  sendDTMF(String letters, [Map<String, dynamic> x = null]) {
    if (Platform.isAndroid) {
      nativeChannel.invokeMethod("lpSendDtmf", [uuid, letters]);
    }
  }

  mute([bool x, bool y]) {
    nativeChannel.invokeMethod("lpMuteCall", [uuid]);
  }
  unmute([bool x, bool y]) {
    nativeChannel.invokeMethod("lpUnmuteCall", [uuid]);
  }

  refer(String destination) {
    nativeChannel.invokeMethod("lpRefer", [uuid, destination]);
  }

  void setState(CallState newState) {print("1");
    state = newState.state;print("2");
  }
}