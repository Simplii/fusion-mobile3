import 'dart:io';


import 'package:audioplayers/audioplayers.dart' as Aps;
import 'package:callkeep/callkeep.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_sip_ua_helper.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:sip_ua/sip_ua.dart';
import '../../main.dart';
import '../utils.dart';
import 'fusion_connection.dart';
import 'package:flutter_incall/flutter_incall.dart';

class Softphone implements SipUaHelperListener {
  String outputDevice = "Phone";
  MediaStream _localStream;
  MediaStream _remoteStream;
  final FusionSIPUAHelper helper = FusionSIPUAHelper();
  List<Function> _listeners = [];
  bool interrupted = false;
  BuildContext _context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      registerNotifications();

  MethodChannel _callKit;
  MethodChannel _telecom;

  bool registered = false;
  bool connected = false;
  bool _settingupcallkeep = false;
  String couldGetAudioSession = "";

  FlutterCallkeep _callKeep;
  Map<String, Map<String, dynamic>> callData = {};
  List<Call> calls = [];
  Call activeCall;
  String _awaitingCall = "none";
  Map<String, int> _tempUUIDs = {};
  final FusionConnection _fusionConnection;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _savedOutput = false;
  Aps.AudioPlayer _playingAudio;
  bool isCellPhoneCallActive = false;
  //AudioSession _audioSession;
  bool _isAudioSessionActive = false;
  bool _attemptingToRegainAudio = false;

  List<String> callIdsAnswered = [];
  //IncallManager incallManager = new IncallManager();

  final Aps.AudioCache _audioCache = Aps.AudioCache(
    fixedPlayer: Aps.AudioPlayer()..setReleaseMode(Aps.ReleaseMode.LOOP),
  );
  final _outboundAudioPath = "audio/outbound.mp3";
  final _inboundAudioPath = "audio/inbound.mp3";
  Aps.AudioPlayer _outboundPlayer;
  Aps.AudioPlayer _inboundPlayer;
  bool _blockingEvent = false;



  Softphone(this._fusionConnection) {
    if (Platform.isIOS)
      _callKit = MethodChannel('net.fusioncomm.ios/callkit');
    else if (Platform.isAndroid)
      _telecom = MethodChannel('net.fusioncomm.android/telecom');

    _audioCache.load(_outboundAudioPath);
    _audioCache.load(_inboundAudioPath);
  }

  close() async {
    try {
      // helper.unregister(true);
      await helper.stop();
      //helper.terminateSessions({});
    } catch (e) {
      print("error closing");
    }
  }

  _playAudio(String path, bool ignore) {
    if (Platform.isIOS && !ignore)
      return;
    else {
      Aps.AudioCache cache = Aps.AudioCache();
      if (path == _outboundAudioPath) {
        cache.loop(_outboundAudioPath).then((Aps.AudioPlayer playing) {
          _outboundPlayer = playing;
          _outboundPlayer.earpieceOrSpeakersToggle();
        });
      } else if (path == _inboundAudioPath) {
        cache.loop(_inboundAudioPath).then((Aps.AudioPlayer playing) {
          _inboundPlayer = playing;
        });
      }
    }
  }

  _attemptToRegainAudioSession() async { return;
     _attemptingToRegainAudio = true;
    try {
      await _callKit.invokeMethod('attemptAudioSessionActive');
    } on PlatformException catch (e) {
      print("error callkit invoke attempt audio session");
    }
    var future = new Future.delayed(const Duration(milliseconds: 10000), () {
        if (couldGetAudioSession != "") {
          _attemptToRegainAudioSession();
        } else {
          _attemptingToRegainAudio = false;
        }
      });
  }

  stopOutbound() {
    if (_outboundPlayer != null) {
      _outboundPlayer.stop();
      _outboundPlayer.release();
    }
  }

  stopInbound() {
    if (_inboundPlayer != null) {
      _inboundPlayer.stop();
      _inboundPlayer.release();
    }
  }

  setContext(BuildContext context) {
    _context = context;
    setup();
  }

  setup() {
    setupPermissions();

    if (Platform.isIOS)
      _setupCallKit();
    else if (Platform.isAndroid) {
      _callKeep = FlutterCallkeep();
      _setupCallKeep();

      FlutterPhoneState.rawPhoneEvents.forEach((element) {
        if (element.type == RawEventType.connected && activeCall != null && !_blockingEvent) {
          isCellPhoneCallActive = true;
          activeCall.hold();
        }
        else if (element.type == RawEventType.disconnected) {
          isCellPhoneCallActive = false;
        }
      });
    }
  }

  _setupTelecom() {
    _telecom.setMethodCallHandler(_telecomHandler);
  }

  Future<dynamic> _telecomHandler(MethodCall methodCall) async {
    print("telecommessage:" + methodCall.method);
    switch (methodCall.method) {
      case 'setPushToken':
        String token = methodCall.arguments[0] as String;
        _fusionConnection.setPushkitToken(token);
        return;
    }
  }

  _setupCallKit() {
    _callKit.setMethodCallHandler(_callKitHandler);
  }

  _setupCallKeep() {
    _callKeep.on(
        CallKeepDidDisplayIncomingCall(), _callKeepDidDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), _callKeepAnswerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), _callKeepDTMFPerformed);
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
          'channelId': 'net.fusioncomm.android',
          'channelName': 'Foreground service for my app',
          'notificationTitle': 'My app is running on background',
          'notificationIcon': 'Path to the resource icon of the notification',
        },
      },
    };

    if (!_settingupcallkeep) {
      _settingupcallkeep = true;
      _callKeep.setup(_context, callSetup);
    }

    if (Platform.isAndroid) {
      //if (isIOS) iOS_Permission();
      //_firebaseMessaging.requestNotificationPermissions();
print("audiofocusaddlistener");

      /*incallManager.onAudioFocusChange.stream.listen((event) {
        print("audiofocuschange");
        print(event);
      });*/

      FirebaseMessaging.instance.getToken().then((token) {
        print('[FCM] token => ' + token);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
      });
    }
  }

  Future<dynamic> _callKitHandler(MethodCall methodCall) async {
    print("callkitmethod:" + methodCall.method);
    print(methodCall.method);
    print(methodCall);
    switch (methodCall.method) {
      case 'setPushToken':
        String token = methodCall.arguments[0] as String;
        _fusionConnection.setPushkitToken(token);
        return;

      case 'setAudioSessionActive':
        bool status = methodCall.arguments[0] as bool;
        if (status)
          couldGetAudioSession = activeCall.id;
        else
          couldGetAudioSession = "";
        if (!status && !_attemptingToRegainAudio)
          _attemptToRegainAudioSession();
        else if (status)
          _attemptingToRegainAudio = true;

        return;

      case 'answerButtonPressed':
        String callUuid = methodCall.arguments[0] as String;
        callIdsAnswered.add(callUuid);
        answerCall(_getCallByUuid(callUuid));
        return;

      case 'endButtonPressed':
        String callUuid = methodCall.arguments[0] as String;
        hangUp(_getCallByUuid(callUuid));
        return;

      case 'holdButtonPressed':
        String callUuid = methodCall.arguments[0] as String;
        bool isHold = methodCall.arguments[1] as bool;
        //setHold(_getCallByUuid(callUuid), isHold, false);
        return;

      case 'muteButtonPressed':
        String callUuid = methodCall.arguments[0] as String;
        bool isMute = methodCall.arguments[1] as bool;
        //setMute(_getCallByUuid(callUuid), isMute);
        return;

      case 'dtmfPressed':
        String callUuid = methodCall.arguments[0] as String;
        String digits = methodCall.arguments[1] as String;
        //sendDtmf(_getCallByUuid(callUuid), digits);
        return;

      case 'startCall':
        String callUuid = methodCall.arguments[0] as String;
        String callerId = methodCall.arguments[0] as String;
        String callerName = methodCall.arguments[0] as String;

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

        return;

      default:
        throw MissingPluginException('notImplemented');
    }
  }

  Future<void> _reportOutgoingCall(String uuid) async {
    try {
      await _callKit.invokeMethod('reportOutgoingCall', uuid);
    } on PlatformException catch (e) {
      print("callkit outgoing error");
    }
  }

  register(String login, String password, String aor) {
    UaSettings settings = UaSettings();

    settings.webSocketSettings.allowBadCertificate = true;
    // settings.webSocketUrl = "wss://nms5-slc.simplii.net:9002/";
    settings.webSocketUrl = "ws://mobile-proxy.fusioncomm.net:8080";
    //settings.webSocketUrl = "ws://mobile-proxy.fusioncomm.net:9002";
    //   settings.webSocketUrl = "ws://staging.fusioncomm.net:8081";
    settings.uri = aor;
    settings.authorizationUser = login;
    settings.password = password;
    settings.displayName = aor;

    settings.userAgent = 'Fusion Mobile - Dart';
    settings.dtmfMode = DtmfMode.RFC2833;
    if (Platform.isIOS) {
      settings.iceGatheringTimeout = 500;
    } else if (Platform.isAndroid) {
      settings.iceGatheringTimeout = 1000;
    }
    settings.iceServers = [
      {"urls": "stun:stun.l.google.com:19305"},
      {"urls": "stun:stun.l.google.com:19302"},
      {"urls": "stun:srvfusturn.fusioncomm.net"},
      {
        "urls": "turn:srvfusturn.fusioncomm.net",
        "username": "fuser",
        "credential": "fpassword"
      }
    ];

    helper.start(settings);
    helper.addSipUaHelperListener(this);
  }

  reregister() {
    print("reregistering...");
    helper.register();
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

  makeCall(String destination) async {
    doMakeCall(destination);
  }

  doMakeCall(String destination) async {
    final mediaConstraints = <String, dynamic>{'audio': true, 'video': false};
    helper.setVideo(false);
    MediaStream mediaStream;
    mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    return helper.call(destination, voiceonly: true, mediaStream: mediaStream);
  }

  makeActiveCall(Call call) {
    if (Platform.isAndroid && activeCall == null) {
      print("audioincallmanager.start");
      //incallManager.start();
    }
    activeCall = call;
    if (Platform.isAndroid) {
      _callKeep.setCurrentCallActive(_uuidFor(call));
    }
    call.unmute();
    call.unhold();
    print("making active callkit call:" + call.id + ":" + call.direction);

    if (_getCallDataValue(call.id, "isReported") != true &&
        call.direction == "OUTGOING") {
      if (Platform.isIOS) {
        print("reportoing outging call callkit");
        _setCallDataValue(call.id, "isReported", true);
        _callKit.invokeMethod("reportOutgoingCall",
            [_uuidFor(call), getCallerNumber(call), getCallerName(call)]);
      }
    }

    for (Call c in calls) {
      if (c.id != call.id) {
        setHold(c, true, false);
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
            return;
          }
        }
      }
    }
  }

  sendDtmf(Call call, String tone, bool fromUi) {
    if (Platform.isAndroid && fromUi) {
      _callKeep.sendDTMF(_uuidFor(call), tone);
    }
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
    if (_localStream != null) {
      var tracks = _localStream.getAudioTracks();
      for (var track in tracks) {
        if (Platform.isIOS) {
          track.enableSpeakerphone(useSpeaker);
        } else {
          track.enableSpeakerphone(useSpeaker);
        }
      }
    }
    this.outputDevice = useSpeaker ? 'Speaker' : 'Phone';
    this._updateListeners();
  }

  isSpeakerEnabled() {
    return this.outputDevice == 'Speaker';
  }

  setHold(Call call, bool setOnHold, bool fromUi) async {
    _setCallDataValue(call.id, "onHold", setOnHold);
    if (setOnHold) {
      if (Platform.isAndroid && fromUi) {
          _callKeep.setOnHold(_uuidFor(call), true);
      }
      helper.setVideo(true);
      call.hold();
      var future = new Future.delayed(const Duration(milliseconds: 2000), () {
        helper.setVideo(false);
      });
    } else {
      if (Platform.isIOS && fromUi) {
        _callKit.invokeMethod("setUnhold", [_uuidFor(call)]);

      }
      else if (Platform.isAndroid && fromUi) {
          _callKeep.setOnHold(_uuidFor(call), false);
      }

      call.unhold();
      couldGetAudioSession = "";
      var future = new Future.delayed(const Duration(milliseconds: 2000), () {
          });
    }
  }

  setMute(Call call, bool setMute, bool fromUi) {
    if (setMute) {
      _setCallDataValue(call.id, "muted", true);
      call.mute();
      if (Platform.isAndroid && fromUi) {
        _callKeep.setMutedCall(_uuidFor(call), true);
      }
    } else {
      _setCallDataValue(call.id, "muted", false);
      call.unmute();
      if (Platform.isAndroid && fromUi) {
        _callKeep.setMutedCall(_uuidFor(call), false);
      }
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
    if (call == null)
      return;
    else if (_getCallDataValue(call.id, "answerTime") != null)
      return;
    else {
      if (callIdsAnswered.contains(_uuidFor(call))) {
        callIdsAnswered.remove(_uuidFor(call));
      }

      final mediaConstraints = <String, dynamic>{'audio': true, 'video': false};
      MediaStream mediaStream;
      mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      call.answer(helper.buildCallOptions(), mediaStream: mediaStream);
      if (Platform.isAndroid) {
        _callKeep.answerIncomingCall(_uuidFor(call));
      }
      makeActiveCall(call);
      _setCallDataValue(call.id, "answerTime", DateTime.now());

      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin.cancel(intIdForString(call.id));
        flutterLocalNotificationsPlugin
            .cancel(intIdForString(_getCallDataValue(call.id, "apiTermId")));
        flutterLocalNotificationsPlugin.cancelAll();
      }
    }
  }

  backToForeground() {
    _callKeep.backToForeground();
  }

  Future<void> handleIncomingCall(String uuid) async {
    Call call = _getCallByUuid(uuid);
    String contactName = getCallerName(call);
  }

  _callKeepDidDisplayIncomingCall(CallKeepDidDisplayIncomingCall event) {
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
  }

  _replaceTempUUID(String tempUuid, String callKeepUuid) {
    _tempUUIDs.remove(tempUuid);
    bool matched = false;
    for (Map<String, dynamic> data in callData.values) {
      if (data['uuid'] == tempUuid) {
        data['uuid'] = callKeepUuid;
      }
    }
  }

  _callKeepDTMFPerformed(CallKeepDidPerformDTMFAction event) {
    sendDtmf(_getCallByUuid(event.callUUID), event.digits, false);
  }

  _callKeepAnswerCall(CallKeepPerformAnswerCallAction event) {
    Call call = _getCallByUuid(event.callUUID);
    answerCall(call);
  }

  _callKeepDidReceiveStartCall(CallKeepDidReceiveStartCallAction event) {}

  _callKeepDidPerformSetMuted(CallKeepDidPerformSetMutedCallAction event) {
    setMute(_getCallByUuid(event.callUUID), event.muted, false);
  }

  _callKeepDidToggleHold(CallKeepDidToggleHoldAction event) {
      setHold(_getCallByUuid(event.callUUID), event.hold, false);
  }

  _callKeepPerformEndCall(CallKeepPerformEndCallAction event) {
  //  hangUp(_getCallByUuid(event.callUUID));
    // i dont think this should need to be ran from callkeep, since
    // it should place the call on hold if needed.
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

  _didDisplayCall() {}

  _removeCall(Call call) {
    if (Platform.isIOS) {
      _callKit.invokeMethod("endCall", [_uuidFor(call)]);
    } else if (Platform.isAndroid) {
      _callKeep.endCall(_uuidFor(call));
    }

    if (call == activeCall) {
      activeCall = null;
     // incallManager.stop();
      print("audioincallmanagerstop:");
    }

    List<Call> toRemove = [];

    for (Call c in calls) {
      if (c == call || c.id == call.id) {
        toRemove.add(c);
      }
    }

    for (Call c in toRemove) calls.remove(c);

    if (calls.length > 0) {
      makeActiveCall(calls[0]);
    } else {
      setCallOutput(call, "phone");
    }

    _updateListeners();
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.cancel(intIdForString(call.id));
      flutterLocalNotificationsPlugin
          .cancel(intIdForString(_getCallDataValue(call.id, "apiTermId")));
      flutterLocalNotificationsPlugin.cancel(intIdForString(call.id));
      flutterLocalNotificationsPlugin.cancelAll();
    }

  }

  _linkUuidFor(Call call) {
    _uuidFor(call);
  }

  _uuidFor(Call call) {
    Map<String, dynamic> data = _getCallDataById(call.id);
    if (data.containsKey('uuid')) {
      return data['uuid'];
    } else {
      String uuid = uuidFromString(call.id);

      if (_awaitingCall != "none") {
        uuid = _awaitingCall;
        _awaitingCall = "none";
      } else {
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
      if (Platform.isAndroid) {}
      calls.add(call);
      _linkUuidFor(call);

      if (activeCall == null) makeActiveCall(call);

      if (call.direction == "INCOMING") {
        _playAudio(_inboundAudioPath, false);
      } else {
        _playAudio(_outboundAudioPath, false);
      }

      if (Platform.isAndroid) {
        final bool hasPhoneAccount = await _callKeep.hasPhoneAccount();

        if (!hasPhoneAccount) {
          await _callKeep.hasDefaultPhoneAccount(_context, <String, dynamic>{
            'alertTitle': 'Permissions required',
            'alertDescription':
                'This application needs to access your phone accounts',
            'cancelButton': 'Cancel',
            'okButton': 'ok',
            'foregroundService': {
              'channelId': 'net.fusioncomm.android',
              'channelName': 'Foreground service for my app',
              'notificationTitle': 'My app is running on background',
              'notificationIcon':
                  'Path to the resource icon of the notification',
            },
          });
        }
      }

      _fusionConnection.callpopInfos.lookupPhone(call.remote_identity,
          (CallpopInfo data) {
        if (Platform.isAndroid) {
          _callKeep.updateDisplay(_uuidFor(call),
              displayName: data.getName(defaul: call.remote_display_name),
              handle: call.remote_identity);
        }
        if (call.direction == "outbound" || call.direction == "OUTGOING")
          _setCallDataValue(call.id, "callPopInfo", data);
      });

      _setCallDataValue(call.id, "startTime", DateTime.now());
    }

    if (callIdsAnswered.contains(_uuidFor(call))) answerCall(call);
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
    setSpeaker(outputDevice == 'speaker');
  }

  isCallMerged(Call call) {
    return _getCallDataValue(call.id, "mergedWith") != null;
  }

  mergedCall(Call call) {
    return _getCallById(_getCallDataValue(call.id, "mergedWith"));
  }

  mergeCalls(Call call, Call call2) {
    call2.peerConnection.getLocalDescription().then((value) {});
    call.peerConnection.getLocalDescription().then((value) {});
    MediaStream call2Remote = call2.peerConnection.getRemoteStreams()[1];
    call.peerConnection.getRemoteStreams().map((MediaStream m) {
      call2.peerConnection.addStream(m);
      m.getAudioTracks().map((MediaStreamTrack mt) {
        call2.peerConnection.addTrack(mt);
      });
    });
    MediaStream callRemote = call.peerConnection.getRemoteStreams()[1];
    call2.peerConnection.getRemoteStreams().map((MediaStream m) {
      call.peerConnection.addStream(m);
      m.getAudioTracks().map((MediaStreamTrack mt) {
        call.peerConnection.addTrack(mt);
      });
    });
    _setCallDataValue(call.id, "mergedWith", call2.id);
    _setCallDataValue(call2.id, "mergedWith", call.id);

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
  }

  recordCall(Call call) {
    _setCallDataValue(call.id, "isRecording", true);
    Map<String, String> ids = _getCallApiIds(call);

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
    switch (callState.state) {
      case CallStateEnum.STREAM:
        _blockingEvent = true;
        var future = new Future.delayed(const Duration(milliseconds: 2000), () {
          _blockingEvent = false;
        });
        _handleStreams(callState);
        if (Platform.isIOS) {
          // for some reason ios defaults to speakerphone and wont let me change
          // that until after this event.
          for (var i = 1250; i < 10000; i += 1500) {
            var future = new Future.delayed(Duration(milliseconds: i), () {
              setCallOutput(call, getCallOutput(call));
            });
          }
        }
        break;
      case CallStateEnum.ENDED:
        stopOutbound();
        stopInbound();
        _removeCall(call);
        break;
      case CallStateEnum.FAILED:
        stopOutbound();
        stopInbound();
        _removeCall(call);
        break;
      case CallStateEnum.UNMUTED:
        _setCallDataValue(call.id, "muted", false);
        break;
      case CallStateEnum.MUTED:
        _setCallDataValue(call.id, "muted", true);
        break;
      case CallStateEnum.CONNECTING:
        break;
      case CallStateEnum.PROGRESS:

        break;
      case CallStateEnum.ACCEPTED:
        _blockingEvent = true;
        var future = new Future.delayed(const Duration(milliseconds: 2000), () {
          _blockingEvent = false;
        });
        if (Platform.isAndroid) {
          setCallOutput(call, getCallOutput(call));
        }
        break;
      case CallStateEnum.CONFIRMED:
        stopOutbound();
        stopInbound();
        if (Platform.isAndroid) {
          setCallOutput(call, getCallOutput(call));
        }
        _setCallDataValue(call.id, "answerTime", DateTime.now());

        _blockingEvent = true;
        var future = new Future.delayed(const Duration(milliseconds: 2000), () {
          _blockingEvent = false;
        });

        if (!isIncoming(call)) {
          if (Platform.isAndroid) {
            _callKeep.reportConnectedOutgoingCallWithUUID(_uuidFor(call));
          }
        } else {
          if (Platform.isAndroid) {
            _callKeep.answerIncomingCall(_uuidFor(call));
          }
        }
        break;
      case CallStateEnum.HOLD:
        _setCallDataValue(call.id, "onHold", true);
        break;
      case CallStateEnum.UNHOLD:
        _setCallDataValue(call.id, "onHold", false);
        break;
      case CallStateEnum.NONE:
        break;
      case CallStateEnum.CALL_INITIATION:
        _addCall(call);
        if (Platform.isAndroid) {
          setCallOutput(call, getCallOutput(call));

          if (isIncoming(call)) {
            _callKeep.displayIncomingCall(_uuidFor(call), getCallerName(call));
          }
          else {
            _callKeep.startCall(_uuidFor(call), getCallerNumber(call), getCallerName(call));
          }
          if (Platform.isAndroid) {
            _blockingEvent = true;
            var future = new Future.delayed(const Duration(milliseconds: 2000), () {
              _blockingEvent = false;
            });

            //TODO: do this in a less hacky way
            for (var i = 1000; i < 10000; i += 1500) {
              var future = new Future.delayed(Duration(milliseconds: i), () {
                _callKeep.updateDisplay(
                    _uuidFor(call),
                    handle: getCallerNumber(call),
                    displayName: getCallerName(call));
              });
            }
          }
        }
        break;
      case CallStateEnum.REFER:
        break;
    }
    _updateListeners();
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {}

  @override
  void registrationStateChanged(RegistrationState state) {

    if (state.state == RegistrationStateEnum.UNREGISTERED) {
      registered = false;
    } else if (state.state == RegistrationStateEnum.REGISTRATION_FAILED) {
      registered = false;
    } else if (state.state == RegistrationStateEnum.NONE) {
      registered = this.helper.registered;
    } else if (state.state == RegistrationStateEnum.REGISTERED) {
      registered = true;
    }
    connected = this.helper.connected;
    _updateListeners();

    if (!registered) {
      var future = new Future.delayed(const Duration(milliseconds: 10000), () {
        if (!this.helper.registered) this.reregister();
      });
    }
  }

  @override
  void transportStateChanged(TransportState state) {}

  @override
  void onNewNotify( ntf) {
    print("new notify");
    print(ntf);
  }
}
