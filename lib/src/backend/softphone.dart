import 'dart:io';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:uuid/uuid.dart';

import 'fusion_connection.dart';

class Softphone implements SipUaHelperListener {
  String outputDevice = "Phone";
  MediaStream _localStream;
  MediaStream _remoteStream;
  final SIPUAHelper helper = SIPUAHelper();
  List<Function> _listeners = [];
  FlutterCallkeep _callKeep;
  BuildContext _context;

  Map<String, Map<String, dynamic>> callData = {};
  List<Call> calls = [];
  Call activeCall;
  String _awaitingCall = "none";
  Map<String, int> _tempUUIDs = {};
  final FusionConnection _fusionConnection;

  Softphone(this._fusionConnection) {
    setup();
  }

  setContext(BuildContext context) {
    _context = context;
    setup();
  }

  setup() {
    print("setting up");
    _callKeep = FlutterCallkeep();
    setupPermissions();
    setupCallKeep();
    print(_callKeep);
  }

  register(String login, String password, String aor) {
    UaSettings settings = UaSettings();

    settings.webSocketSettings.allowBadCertificate = true;
    settings.webSocketUrl = "wss://nms5-slc.simplii.net:9002/";
    settings.uri = aor;
    settings.authorizationUser = login;
    settings.password = password;
    settings.displayName = aor;
    settings.userAgent = 'Fusion Mobile - Dart';
    settings.dtmfMode = DtmfMode.RFC2833;
    settings.iceServers = [
      {'url': 'stun:stun.l.google.com:19302'},
      {
        'urls': "turn:143.110.144.174",
        'username': "fuser",
        'credential': "fwebphoneuser"
      }
    ];

    helper.start(settings);
    helper.addSipUaHelperListener(this);
  }

  setupPermissions() {
    FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        criticalAlert: true,
        provisional: false,
        sound: true);

    FirebaseMessaging.instance.getToken().then((String key) {
      print("firebase token - " + key);
    });
  }

  setupCallKeep() {
    _callKeep.on(
        CallKeepDidDisplayIncomingCall(), _callKeepDidDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), _callKeepAnswerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), _callKeepDTMFPerformed);
    _callKeep.on(
        CallKeepDidReceiveStartCallAction(), _callKeepDidReceiveStartCall);
    _callKeep.on(CallKeepDidToggleHoldAction(), _callKeepDidToggleHold);
    _callKeep.on(
        CallKeepDidPerformSetMutedCallAction(), _callKeepDidPerformSetMuted);
    _callKeep.on(CallKeepPerformEndCallAction(), _callKeepPerformEndCall);
    _callKeep.on(CallKeepPushKitToken(), _callKeepPushkitToken);

    final callSetup = <String, dynamic>{
      'ios': {
        'appName': 'Fusion Mobile',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
        'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
        'foregroundService': {
          'channelId': 'net.fusioncomm.flutter_app',
          'channelName': 'Foreground service for my app',
          'notificationTitle': 'My app is running on background',
          'notificationIcon': 'Path to the resource icon of the notification',
        },
      },
    };

    _callKeep.setup(null, callSetup);

    if (Platform.isAndroid) {
      //if (isIOS) iOS_Permission();
      //  _firebaseMessaging.requestNotificationPermissions();

      FirebaseMessaging.instance.getToken().then((token) {
        print('[FCM] token => ' + token);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        print("got message");
        print(message);
        print(message);
      });
    }
  }

  makeCall(String destination) async {
    final mediaConstraints = <String, dynamic>{'audio': true, 'video': false};
    MediaStream mediaStream;
    mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    helper.call(destination, voiceonly: true, mediaStream: mediaStream);
  }

  makeActiveCall(Call call) {
    activeCall = call;
    _callKeep.setCurrentCallActive(_uuidFor(call));
    call.unmute();
    call.unhold();

    for (Call c in calls) {
      if (c != call) {
        c.hold();
        c.mute();
      }
    }
    }

  sendDtmf(Call call, String tone) {
    _callKeep.sendDTMF(_uuidFor(call), tone);
    call.sendDTMF(tone);
  }

  isStreamConnected() {
    return _localStream != null;
  }

  registrationState() {
    return helper.registerState.state;
  }

  registrationError() {
    return helper.registerState.cause;
  }

  isRegistered() {
    return helper.registered;
  }

  setSpeaker(bool useSpeaker) {
    _localStream.getAudioTracks()[0].enableSpeakerphone(useSpeaker);
    this.outputDevice = useSpeaker ? 'Speaker' : 'Phone';
  }

  setHold(Call call, bool setOnHold) {
    if (setOnHold) {
      call.hold();
    } else {
      call.unhold();
    }
  }

  setMute(Call call, bool setMute) {
    if (setMute) {
      call.mute();
    } else {
      call.unmute();
    }
  }

  isIncoming(Call call) {
    return call.direction == 'INCOMING';
  }

  isConnected(Call call) {
    return call.state == CallStateEnum.ACCEPTED ||
        call.state == CallStateEnum.CONFIRMED ||
        call.state == CallStateEnum.STREAM ||
        call.state == CallStateEnum.HOLD ||
        call.state == CallStateEnum.UNHOLD ||
        call.state == CallStateEnum.MUTED ||
        call.state == CallStateEnum.UNMUTED;
  }

  transfer(Call call, String destination) {
    call.refer(destination);
    _removeCall(call);
  }

  hangUp(Call call) {
    try {
      call.hangup();
    } catch (e) {}
    _removeCall(call);
  }

  answerCall(Call call) async {
    // this should only be called on android. in iOS the call
    // must be answered through the callkit ui
    print("answering _call - " + _uuidFor(call));
    final mediaConstraints = <String, dynamic>{'audio': true, 'video': false};
    MediaStream mediaStream;
    mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    call.answer(helper.buildCallOptions(), mediaStream: mediaStream);
    print("answering callkeep " + _uuidFor(call));
    _callKeep.answerIncomingCall(_uuidFor(call));
    makeActiveCall(call);
  }

  backToForeground() {
    _callKeep.backToForeground();
  }

  _callKeepDidDisplayIncomingCall(CallKeepDidDisplayIncomingCall event) {
    print("did display call callkeep");
    print(event);

    String callUuid = event.callUUID;
    bool callIdFound = false;
    for (Map<String, dynamic> data in callData.values) {
      if (data.containsKey('uuid') && data['uuid'] == callUuid) {
        callIdFound = true;
      }
    }

    if (!callIdFound) {
      int time = DateTime
          .now()
          .millisecondsSinceEpoch;
      bool matched = false;
      for (String tempUUID in _tempUUIDs.keys) {
        if (time - _tempUUIDs[tempUUID] < 10 * 1000) {
          _replaceTempUUID(tempUUID, callUuid);
          matched = debugInstrumentationEnabled;
        }
      }
      if (!matched) {
        _awaitingCall = callUuid;
      }
    }
    print("_call did display: " + callUuid + " - " + _awaitingCall);
  }

  _replaceTempUUID(String tempUuid, String callKeepUuid) {
    _tempUUIDs.remove(tempUuid);
    print("_call replaceing temp uuid - " + tempUuid + " - " + callKeepUuid);
    bool matched = false;
    for (Map<String, dynamic> data in callData.values) {
      if (data['uuid'] == tempUuid) {
        data['uuid'] = callKeepUuid;
        print("did the replacement temp uid _call " + callKeepUuid);
      }
    }
  }

  _callKeepDTMFPerformed(CallKeepDidPerformDTMFAction event) {
    sendDtmf(_getCallByUuid(event.callUUID), event.digits);
  }

  _callKeepAnswerCall(CallKeepPerformAnswerCallAction event) {
    print("_callkeep answer call" + event.callUUID);
    Call call = _getCallByUuid(event.callUUID);
    print("_callkeep answer call got call" + call.toString());
    answerCall(call);
  }

  _callKeepDidReceiveStartCall(CallKeepDidReceiveStartCallAction event) {
    print("did recevie start call action");
    print(event);
  }

  _callKeepDidPerformSetMuted(CallKeepDidPerformSetMutedCallAction event) {
    setMute(_getCallByUuid(event.callUUID), event.muted);
  }

  _callKeepDidToggleHold(CallKeepDidToggleHoldAction event) {
    setHold(_getCallByUuid(event.callUUID), event.hold);
  }

  _callKeepPerformEndCall(CallKeepPerformEndCallAction event) {
    hangUp(_getCallByUuid(event.callUUID));
  }

  _callKeepPushkitToken(CallKeepPushKitToken event) {
    print("callkeep pushkit");
    print(event);
  }

  _getCallByUuid(String uuid) {
    for (String id in callData.keys) {
      if (callData[id]['uuid'] == uuid) {
        return _getCallById(id);
      }
    }
    return null;
  }

  _handleStreams(CallState event) async {
    MediaStream stream = event.stream;
    if (event.originator == 'local') {
      _localStream = stream;
    }
    if (event.originator == 'remote') {
      _remoteStream = stream;
    }
  }

  _didDisplayCall() {
    print("call did display");
  }

  _removeCall(Call call) {
    print("removing _call_ - " + call.id);
    if (call == activeCall) {
      activeCall = null;
    }

    for (Call c in calls) {
      if (c == call || c.id == call.id) {
        calls.remove(c);
        _removeDataFor(c);
        _callKeep.endCall(_uuidFor(c));
      }
    }

    _updateListeners();
  }

  _uuidFor(Call call) {
    Map<String, dynamic> data = _getCallDataById(call.id);
    if (data.containsKey('uuid')) {
      return data['uuid'];
    } else {
      String uuid = Uuid().v4();

      if (_awaitingCall != "none") {
        uuid = _awaitingCall;
        _awaitingCall = "none";
      } else {
        print("_call setting temp uuid " + uuid);
        _tempUUIDs[uuid] = DateTime
            .now()
            .millisecondsSinceEpoch;
      }
      data['uuid'] = uuid;
      return uuid;
    }
  }

  _removeDataFor(Call call) {
    callData.remove(call.id);
  }

  void _setCallDataValue(String id, String name, dynamic value) {
    var data = _getCallDataById(id);
    data[name] = value;
    _updateListeners();
  }

  dynamic _getCallDataValue(String id, String name, {dynamic def}) {
    var data = _getCallDataById(id);
    return data[name] == null ? def : data[name];
  }

  _getCallDataById(String id) {
    if (callData.containsKey(id)) {
      return callData[id];
    } else {
      callData[id] = Map<String, dynamic>();
      callData[id]['onHold'] = false;
      return callData[id];
    }
  }

  _getCallById(String id) {
    for (Call call in calls) {
      if (call.id == id) {
        return call;
      }
    }
    return null;
  }

  _callIsAdded(Call call) {
    for (Call c in calls) {
      if (c.id == call.id) {
        return true;
      }
    }
    return false;
  }

  _addCall(Call call) async {
    if (!_callIsAdded(call)) {
      /*_callKeep.startCall(
          _uuidFor(call), call.remote_identity, call.remote_display_name);*/
      calls.add(call);
      makeActiveCall(call);

      final bool hasPhoneAccount = await _callKeep.hasPhoneAccount();
      if (!hasPhoneAccount) {
        await _callKeep.hasDefaultPhoneAccount(_context, <String, dynamic>{
          'alertTitle': 'Permissions required',
          'alertDescription':
          'This application needs to access your phone accounts',
          'cancelButton': 'Cancel',
          'okButton': 'ok',
          'foregroundService': {
            'channelId': 'net.fusioncomm.flutter_app',
            'channelName': 'Foreground service for my app',
            'notificationTitle': 'My app is running on background',
            'notificationIcon': 'Path to the resource icon of the notification',
          },
        });
      }
      print("getting callpop info " + call.remote_identity);
      _fusionConnection.callpopInfos.lookupPhone(call.remote_identity,
              (CallpopInfo data) {
            _callKeep.updateDisplay(_uuidFor(call),
                displayName: data.getName(defaul: call.remote_display_name),
                handle: call.remote_identity);
            _setCallDataValue(call.id, "callPopInfo", data);
            print("got callpop info");
            print(data);
          });


      _setCallDataValue(call.id, "startTime", DateTime.now());
      //    _callKeep.displayIncomingCall(_uuidFor(call), call.remote_identity,
      //        handleType: 'number', hasVideo: false);
    }
  }

  onUpdate(Function listener) {
    _listeners.add(listener);
  }

  _updateListeners() {
    for (Function listener in this._listeners) {
      listener();
    }
  }

  CallpopInfo getCallpopInfo(String id) {
    return _getCallDataValue(id, "callPopInfo") as CallpopInfo;
  }

  getCallerName(Call call) {
    CallpopInfo data = getCallpopInfo(call.id);
    if (data != null) {
      return data.getName();
    }
    else {
      return call.remote_display_name;
    }
  }


  String getCallerCompany(Call call) {
    CallpopInfo data = getCallpopInfo(call.id);
    if (data != null) {
      return data.getCompany();
    }
    else {
      return "";
    }
  }

  getCallerNumber(Call call) {
    return call.remote_identity;
  }

  int getCallRunTime(Call call) {
    DateTime time = _getCallDataValue(call.id, "answerTime") as DateTime;
    if (time == null)
      time = _getCallDataValue(call.id, "startTime") as DateTime;
    if (time == null)
      return 0;
    else
      return DateTime.now().difference(time).inSeconds;
  }

  getRecordState(Call call) {
    return _getCallDataValue(call.id, "isRecording", def: false);
  }

  getHoldState(Call call) {
    return _getCallDataValue(call.id, "onHold", def: false);
  }

  recordCall(Call call) {
    _setCallDataValue(call.id, "isRecording", true);
    _fusionConnection.nsApiCall(
        "call",
        "record_on",
        {"callid": call.id,
          "uid": _fusionConnection.getUid()},
        callback: (Map<String, dynamic> result) {
        });
  }

  stopRecordCall(Call call) {
    _setCallDataValue(call.id, "isRecording", false);
    _fusionConnection.nsApiCall(
        "call",
        "record_off",
        {"callid": call.id,
          "uid": _fusionConnection.getUid()},
        callback: (Map<String, dynamic> result) {
        });
  }

  @override
  void callStateChanged(Call call, CallState callState) {
    if (callState.state == CallStateEnum.MUTED) {
      return;
    }

    if (callState.state == CallStateEnum.UNMUTED) {
      return;
    }

    if (callState.state != CallStateEnum.STREAM) {}

    print("event- _call_ -" +
        call.direction +
        " - " +
        callState.state.toString() +
        " + " +
        call.id);
    switch (callState.state) {
      case CallStateEnum.STREAM:
        _handleStreams(callState);
        break;
      case CallStateEnum.ENDED:
        _removeCall(call);
        break;
      case CallStateEnum.FAILED:
        _removeCall(call);
        break;
      case CallStateEnum.UNMUTED:
        _callKeep.setMutedCall(_uuidFor(call), false);
        break;
      case CallStateEnum.MUTED:
        _callKeep.setMutedCall(_uuidFor(call), true);
        break;
      case CallStateEnum.CONNECTING:
      case CallStateEnum.PROGRESS:
        break;
      case CallStateEnum.ACCEPTED:
      case CallStateEnum.CONFIRMED:
        _setCallDataValue(call.id, "answerTime", DateTime.now());
        if (!isIncoming(call)) {
          print("_call connecting out going" + _uuidFor(call));
          _callKeep.reportConnectedOutgoingCallWithUUID(_uuidFor(call));
        } else {
          print("_call connecting incoming " + _uuidFor(call));
          _callKeep.answerIncomingCall(_uuidFor(call));
        }
        break;
      case CallStateEnum.HOLD:
        Map<String, dynamic> updatedCall = _getCallDataById(call.id);
        updatedCall['onHold'] = true;

        _callKeep.setOnHold(_uuidFor(call), true);
        break;
      case CallStateEnum.UNHOLD:
        Map<String, dynamic> updatedCall = _getCallDataById(call.id);
        updatedCall['onHold'] = false;

        _callKeep.setOnHold(_uuidFor(call), false);
        break;
      case CallStateEnum.NONE:
        break;
      case CallStateEnum.CALL_INITIATION:
        _addCall(call);
        break;
      case CallStateEnum.REFER:
        break;
    }
    _updateListeners();
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
    print("message");
    print(msg);
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    print(state);
    _updateListeners();
    // TODO: implement registrationStateChanged
  }

  @override
  void transportStateChanged(TransportState state) {
    print(state);
    // TODO: implement transportStateChanged
  }
}
