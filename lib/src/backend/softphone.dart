import 'dart:io';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:uuid/uuid.dart';
import 'package:ringtone_player/ringtone_player.dart';
import '../../main.dart';
import '../utils.dart';
import 'fusion_connection.dart';

class Softphone implements SipUaHelperListener {
  String outputDevice = "Phone";
  MediaStream _localStream;
  MediaStream _remoteStream;
  final SIPUAHelper helper = SIPUAHelper();
  List<Function> _listeners = [];
  FlutterCallkeep _callKeep;
  BuildContext _context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        registerNotifications();

  Map<String, Map<String, dynamic>> callData = {};
  List<Call> calls = [];
  Call activeCall;
  String _awaitingCall = "none";
  Map<String, int> _tempUUIDs = {};
  final FusionConnection _fusionConnection;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  AudioPlayer outboundRingtone = AudioPlayer();
  AudioPlayer inboundRingtone = AudioPlayer();
  bool _savedOutput = false;

  Softphone(this._fusionConnection) {
    setup();
    outboundRingtone.setAsset("assets/audio/outbound.mp3");
    outboundRingtone.setLoopMode(LoopMode.one);

    inboundRingtone.setAsset("assets/audio/inbound.mp3");
    inboundRingtone.setLoopMode(LoopMode.one);
  }

  setContext(BuildContext context) {
    _context = context;
    setup();
  }

  setup() {
    print("setting up");
    //FlutterVoipKit.init(
//        callStateChangeHandler: callStateChangeHandler,
    //      callActionHandler: callActionHandler);

    _callKeep = FlutterCallkeep();
    setupPermissions();
    setupCallKeep();
    print(_callKeep);
  }

  /*Future<bool> callStateChangeHandler(call) async {
    print("widget call state changed lisener: $call");

    //it is important we perform logic and return true/false for every CallState possible
    switch (call.callState) {
      case voipKit.CallState
          .connecting: //simulate connection time of 3 seconds for our VOIP service
        print("--------------> Call connecting");
        await Future.delayed(const Duration(seconds: 3));
        return true;
      case voipKit.CallState
          .active: //here we would likely begin playig audio out of speakers
        print("--------> Call active");
        return true;            //
      case voipKit.CallState.ended: //end audio, disconnect
        print("--------> Call ended");
        await Future.delayed(const Duration(seconds: 1));
        return true;
      case voipKit.CallState.failed: //cleanup
        print("--------> Call failed");
        return true;
      case voipKit.CallState.held: //pause audio for specified call
        print("--------> Call held");
        return true;
      default:
        return false;
    }
  }

  Future<bool> callActionHandler(voipKit.Call call, voipKit.CallAction action) async {
    print("call action -- " + call.uuid + " - " + action.toString());
  }*/

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

      _firebaseMessaging.getToken().then((token) {
        print("gotfbtoken: " + token);
        _fusionConnection.apiV1Call(
          "post",
          "/clients/device_token",
          {"token": token},
        );
      });
    }
  }

  makeCall(String destination) async {
    final mediaConstraints = <String, dynamic>{'audio': true, 'video': false};
    MediaStream mediaStream;
    mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    outboundRingtone.play();

    helper.call(destination, voiceonly: true, mediaStream: mediaStream);
  }

  makeActiveCall(Call call) {
    print("makeactive");print(call);
    activeCall = call;
    _callKeep.setCurrentCallActive(_uuidFor(call));
    call.unmute();
    call.unhold();

    for (Call c in calls) {
      print("checking hold" + c.id);
      if (c.id != call.id) {
        print("holding:" + c.id);
        c.hold();
        c.mute();
        print("held:" + c.id);
      }
    }
  }

  _setApiIds(call, termId, origId) {
    _setCallDataValue(call.id, "apiTermId", termId);
    _setCallDataValue(call.id, "apiOrigId", origId);
  }

  _callHasApiIds(call) {
    return _getCallDataValue(call.id, "apiTermId") != null;
  }

  Map<String, String> _getCallApiIds(call) {
    return {
      "term": _getCallDataValue(call.id, "apiTermId"),
      "orig": _getCallDataValue(call.id, "apiOrigId")
    };
  }

  checkCallIds(Map<String, dynamic> message) {
    if (message.containsKey('term_id')) {
      print("checking ids:" + message.toString());
      for (Call call in calls) {
        if (!_callHasApiIds(call)) {
          if ((message["term_id"] as String).onlyNumbers() ==
                  ("" + getCallerNumber(call)).onlyNumbers() ||
              (message["orig_id"] as String).onlyNumbers() ==
                  ("" + getCallerNumber(call)).onlyNumbers() ||
              (message["term_sub"] as String).onlyNumbers() ==
                  ("" + getCallerNumber(call)).onlyNumbers() ||
              (message["orig_own_sub"] as String).onlyNumbers() ==
                  ("" + getCallerNumber(call)).onlyNumbers()) {
            _setApiIds(call, message['term_callid'], message['orig_callid']);
            print("setting call ids:" + call.id + ":" + message.toString());
            return;
          }
        }
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
    _savedOutput = useSpeaker;
    print("set speaker:" + useSpeaker.toString());
    _localStream.getAudioTracks()[0].enableSpeakerphone(useSpeaker);
    this.outputDevice = useSpeaker ? 'Speaker' : 'Phone';
  }

  setHold(Call call, bool setOnHold) {
    print("serttingonhold:" + setOnHold.toString());
    _setCallDataValue(call.id, "onHold", setOnHold);
    if (setOnHold) {
      print("holding");
      call.hold();
    } else {
      print("unholding");
      call.unhold();
    }
  }

  setMute(Call call, bool setMute) {
    if (setMute) {
      _setCallDataValue(call.id, "muted", true);
      call.mute();
    } else {
      _setCallDataValue(call.id, "muted", false);
      call.unmute();
    }
  }

  getMuted(Call call) {
    return _getCallDataValue(call.id, "muted", def: false);
  }

  isIncoming(Call call) {
    return call.direction == 'INCOMING';
  }

  isConnected(Call call) {
    return _getCallDataValue(call.id, "answerTime") != null;
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
    final mediaConstraints = <String, dynamic>{'audio': true, 'video': false};
    MediaStream mediaStream;
    mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    call.answer(helper.buildCallOptions(), mediaStream: mediaStream);

    _callKeep.answerIncomingCall(_uuidFor(call));
    makeActiveCall(call);
    _setCallDataValue(call.id, "answerTime", DateTime.now());
    print("answering");
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
      int time = DateTime.now().millisecondsSinceEpoch;
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
    if (_getCallDataValue(_getCallByUuid(event.callUUID).id, "onHold") != event.hold) {
      setHold(_getCallByUuid(event.callUUID), event.hold);
    }
  }

  _callKeepPerformEndCall(CallKeepPerformEndCallAction event) {
    hangUp(_getCallByUuid(event.callUUID));
  }

  _callKeepPushkitToken(CallKeepPushKitToken event) {
    _fusionConnection.setPushkitToken(event.token);
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
    if (call == activeCall) {
      activeCall = null;
    }

    List<Call> toRemove = [];

    for (Call c in calls) {
      if (c == call || c.id == call.id) {
        toRemove.add(c);
        _callKeep.endCall(_uuidFor(c));
      }
    }

    for (Call c in toRemove) calls.remove(c);

    if (calls.length > 0) makeActiveCall(calls[0]);

    _updateListeners();
    if (Platform.isAndroid) {
      String number = getCallerNumber(call);
      flutterLocalNotificationsPlugin.cancel(
          int.parse(number.onlyNumbers()));
    }
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
        _tempUUIDs[uuid] = DateTime.now().millisecondsSinceEpoch;
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
      if (activeCall == null) makeActiveCall(call);

      if (call.direction == "INCOMING")
        inboundRingtone.play();
      else
        outboundRingtone.play();

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
      if (data.getName().trim().length > 0)
        return data.getName();
      else
        return "Unknown";
    } else {
      if (call.remote_display_name != null &&
          call.remote_display_name.trim().length > 0)
        return call.remote_display_name;
      else
        return "Unknown";
    }
  }

  String getCallerCompany(Call call) {
    CallpopInfo data = getCallpopInfo(call.id);
    if (data != null) {
      return data.getCompany();
    } else {
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

  String getCallRunTimeString(Call call) {
    var duration = getCallRunTime(call);
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
    return callRunTime;
  }

  getRecordState(Call call) {
    return _getCallDataValue(call.id, "isRecording", def: false);
  }

  getHoldState(Call call) {
    return _getCallDataValue(call.id, "onHold", def: false);
  }

  getCallOutput(Call call) {
    return this.outputDevice == 'Speaker' ? 'speaker' : 'phone';
  }

  setCallOutput(Call call, String outputDevice) {
    print("setcalloutput:" + outputDevice);
    setSpeaker(outputDevice == 'speaker');
  }

  isCallMerged(Call call) {
    return _getCallDataValue(call.id, "mergedWith") != null;
  }

  mergedCall(Call call) {
    return _getCallById(_getCallDataValue(call.id, "mergedWith"));
  }

  mergeCalls(Call call, Call call2) {
    print("peerconnection1remote:" +
        call.peerConnection.getRemoteStreams().toString());
    print("peerconnection1local:" +
        call.peerConnection.getLocalStreams().toString());
    print("peerconnection2remote:" +
        call2.peerConnection.getRemoteStreams().toString());
    print("peerconnection2local:" +
        call2.peerConnection.getLocalStreams().toString());
    call2.peerConnection.getLocalDescription().then((value) {
      print("local descriptionc2");
      print(value);
    });
    call.peerConnection.getLocalDescription().then((value) {
      print("local descriptionc1");
      print(value);
    });
    MediaStream call2Remote = call2.peerConnection.getRemoteStreams()[1];
    call.peerConnection.getRemoteStreams().map((MediaStream m) {
      call2.peerConnection.addStream(m);
      m.getAudioTracks().map((MediaStreamTrack mt) {
        call2.peerConnection.addTrack(mt);
        print("addtrackc2");
        print(mt);
      });
    });
    MediaStream callRemote = call.peerConnection.getRemoteStreams()[1];
    call2.peerConnection.getRemoteStreams().map((MediaStream m) {
      call.peerConnection.addStream(m);
      m.getAudioTracks().map((MediaStreamTrack mt) {
        call.peerConnection.addTrack(mt);
        print("addtrack");
        print(mt);
      });
    });
    _setCallDataValue(call.id, "mergedWith", call2.id);
    _setCallDataValue(call2.id, "mergedWith", call.id);
    print("merged");
    print(call);
    print(call2);

    createLocalMediaStream('local').then((MediaStream mergedStream) {
      call.peerConnection.getLocalStreams().map((MediaStream m) {
        m.getAudioTracks().map((MediaStreamTrack mt) {
          mergedStream.addTrack(mt);
        });
      });

      call2.peerConnection.getRemoteStreams().map((MediaStream m) {
        m.getAudioTracks().map((MediaStreamTrack mt) {
          mergedStream.addTrack(mt);
        });
      });

      call.peerConnection
          .getLocalStreams()
          .map((stream) => call.peerConnection.removeStream(stream));
      call.peerConnection.addStream(mergedStream);
    });
    //
    //
    // createLocalMediaStream('local').then((MediaStream mergedStream) {
    //   call.peerConnection.getReceivers().then((receivers) {
    //
    //     call2.peerConnection.getSenders().then((senders) {
    //       call2.peerConnection.addTrack(track)
    //       senders.map((sender) {
    //         receivers.map((receiver)  {
    //           sender.trac
    //         });
    //         mergedStream.addTrack(sender.track);
    //       });
    //       senders[0].replaceTrack(mergedStream).
    //     });
    //   });
    //   call.peerConnection.getLocalStreams().map((MediaStream m) {
    //     m.getAudioTracks().map((MediaStreamTrack mt) {
    //       mergedStream.addTrack(mt);
    //     });
    //   });
    //
    //   call2.peerConnection.getRemoteStreams().map((MediaStream m) {
    //     m.getAudioTracks().map((MediaStreamTrack mt) {
    //       mergedStream.addTrack(mt);
    //     });
    //   });
    //
    //   call.peerConnection.getLocalStreams().map((stream) =>
    //       call.peerConnection.removeStream(stream));
    //   call.peerConnection.addStream(mergedStream);
    // });
  }

  recordCall(Call call) {
    _setCallDataValue(call.id, "isRecording", true);
    Map<String, String> ids = _getCallApiIds(call);
    print("ids");
    print(ids);
    _fusionConnection.nsApiCall("call", "record_on",
        {"callid": ids['orig'], "uid": _fusionConnection.getUid()},
        callback: (Map<String, dynamic> result) {});
  }

  stopRecordCall(Call call) {
    _setCallDataValue(call.id, "isRecording", false);
    Map<String, String> ids = _getCallApiIds(call);
    _fusionConnection.nsApiCall("call", "record_off",
        {"callid": ids['orig'], "uid": _fusionConnection.getUid()},
        callback: (Map<String, dynamic> result) {});
  }

  @override
  void callStateChanged(Call call, CallState callState) {
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
        outboundRingtone.stop();
        inboundRingtone.stop();
        _removeCall(call);
        break;
      case CallStateEnum.FAILED:
        outboundRingtone.stop();
        inboundRingtone.stop();

        _removeCall(call);
        break;
      case CallStateEnum.UNMUTED:
        _setCallDataValue(call.id, "muted", false);
        _callKeep.setMutedCall(_uuidFor(call), false);
        break;
      case CallStateEnum.MUTED:
        _setCallDataValue(call.id, "muted", true);
        _callKeep.setMutedCall(_uuidFor(call), true);
        break;
      case CallStateEnum.CONNECTING:
        print("playaudio");
        break;
      case CallStateEnum.PROGRESS:
        print("playoutbound");
        break;
      case CallStateEnum.ACCEPTED:
        outboundRingtone.stop();
        inboundRingtone.stop();
        setCallOutput(call, "phone");
        break;
      case CallStateEnum.CONFIRMED:
        setCallOutput(call, 'phone');
        outboundRingtone.stop();
        inboundRingtone.stop();
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
        _setCallDataValue(call.id, "onHold", true);
        _callKeep.setOnHold(_uuidFor(call), true);
        break;
      case CallStateEnum.UNHOLD:
        _setCallDataValue(call.id, "onHold", false);
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
