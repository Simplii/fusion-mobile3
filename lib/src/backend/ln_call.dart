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
  MethodChannel iosChannel;

  LnCall(String id, RTCSession session, CallStateEnum state) : super(id, session, state);
  LnCall.makeLnCall(String callId, String remoteAddress): super(callId, LnSession(null), CallStateEnum.NONE);

  setIdentities(number, callerid, direction) {
    remote_identity = number;
    remote_display_name = callerid;
    this.direction = direction;
  }

  setChannel(channel, uuid) {
    this.uuid = uuid;
    iosChannel = channel;
  }

  setHold(bool hold) {
    iosChannel.invokeMethod("lpSetHold", [uuid, hold]);
  }

  sendDTMF(String digits, [Map<String, dynamic> arg]) {
    iosChannel.invokeMethod("lpSendDtmf", [uuid, digits]);
  }

  hold() {
    setHold(true);
  }

  unhold() {
    setHold(false);
  }

  answer(Map<String, dynamic> s, {MediaStream mediaStream = null}) {
    iosChannel.invokeMethod("lpAnswer", [uuid]);
  }
  hangup([Map<String, dynamic> x = null]) {
    iosChannel.invokeMethod("lpEndCall", [uuid]);
  }

  mute([bool x, bool y]) {
    iosChannel.invokeMethod("lpMuteCall", [uuid]);
  }
  unmute([bool x, bool y]) {
    iosChannel.invokeMethod("lpUnmuteCall", [uuid]);
  }

  refer(String destination) {
    iosChannel.invokeMethod("lpRefer", [uuid, destination]);
  }

  void setState(CallState newState) {print("1");
    state = newState.state;print("2");
  }
}