import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:callkeep/callkeep.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/callview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:uuid/uuid.dart';

import 'src/backend/fusion_connection.dart';
import 'src/backend/softphone.dart';
import 'src/components/menu.dart';
import 'src/contacts/recent_contacts.dart';
import 'src/dialpad/dialpad.dart';
import 'src/login.dart';
import 'src/messages/messages_list.dart';
import 'src/messages/new_message_popup.dart';
import 'src/styles.dart';

FlutterCallkeep __callKeep = FlutterCallkeep();
bool __callKeepInited = false;

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> pushVideoView() {
    return navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}

Future<dynamic> backgroundMessageHandler(RemoteMessage message) {
  print('backgroundMessage: message => ${message.toString()}');
  print('backgroundMessage: message => ${message.data.toString()}');

  var data = message.data;

  if (data.containsKey("alert") && data['alert'] == "call") {
    var callerName = data['phonenumber'] as String;
    final callUUID = Uuid().v4();
    print("callkeep");
    print(__callKeep);
    __callKeep.on(CallKeepPerformAnswerCallAction(),
        (CallKeepPerformAnswerCallAction event) {
      print(
          'backgroundMessage: CallKeepPerformAnswerCallAction ${event.callUUID}');
      __callKeep.startCall(event.callUUID, callerName, callerName);

      Timer(const Duration(seconds: 1), () {
        print('[setCurrentCallActive] $callUUID, callerName: $callerName');
        __callKeep.setCurrentCallActive(callUUID);
      });
      //_callKeep.endCall(event.callUUID);
    });

    __callKeep.on(CallKeepPerformEndCallAction(),
        (CallKeepPerformEndCallAction event) {
      print(
          'backgroundMessage: CallKeepPerformEndCallAction ${event.callUUID}');
    });

    if (!__callKeepInited) {
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

      __callKeep.setup(null, callSetup);
      __callKeepInited = true;
    }

    print('backgroundMessage: displayIncomingCall ($callerName)');
    __callKeep.displayIncomingCall(callUUID, callerName,
        localizedCallerName: callerName, hasVideo: false);
    __callKeep.backToForeground();

    final SendPort send = IsolateNameServer.lookupPortByName('fusion_port');
    send.send(true);

    // NavigationService.pushVideoView();

  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FusionConnection _fusionConnection;
  Softphone _softphone;

  MyApp() {
    this._fusionConnection = FusionConnection();
    this._softphone = Softphone(_fusionConnection);
  }

  bool _listenerHasBeenSetup = false;

  _setupListener() async {
    /*ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'fusion_port');
    _port.listen((dynamic data) {
      print("portstuff");
      print(data);
      NavigationService.pushVideoView();
      _softphone.backToForeground();
    });
    print("willcheck");
    if (LocalPlatform().isAndroid) {
      print("postintent");
      AndroidIntent intent = AndroidIntent(
        action: 'action_manage_overlay_permission_request_code',
        data: '',
        arguments: {},
      );
      print(intent);
      await intent.launch();
    }*/
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _softphone.setContext(context);
    if (!_listenerHasBeenSetup) {
      _setupListener();
      _listenerHasBeenSetup = true;
    }

    return MaterialApp(
      title: 'Fusion Revamped',
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(
          title: 'Fusion Revamped',
          softphone: _softphone,
          fusionConnection: _fusionConnection),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.softphone, this.fusionConnection})
      : super(key: key);
  final Softphone softphone;
  final FusionConnection fusionConnection;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Softphone get softphone => widget.softphone;

  FusionConnection get fusionConnection => widget.fusionConnection;
  String _sub_login = "";
  String _auth_key = "";
  String _aor = "";
  final phoneNumberController = TextEditingController();
  String receivedMsg;
  List<Call> calls;
  Call activeCall;
  bool _logged_in = false;
  bool _callInProgress = false;

  _logOut() {
    print("logging out");
    Navigator.of(context).popUntil((route) => route.isFirst);
    this.setState(() {
      _logged_in = false;
    });
  }

  @override
  initState() {
    super.initState();
    receivedMsg = "";
    fusionConnection.onLogOut(_logOut);
    softphone.onUpdate(() {
      print("_call_ updated");
      print(softphone.calls);
      setState(() {});
    });
    _register();
  }

  Future<void> _register() async {
    if (_sub_login != "") {
      softphone.register(_sub_login, _auth_key, _aor.replaceAll('sip:', ''));
    } else {
      fusionConnection.nsApiCall('device', 'read', {
        'domain': 'Simplii1',
        'device': 'sip:9812fm@Simplii1',
        'user': '9812'
      }, callback: (Map<String, dynamic> response) {
        Map<String, dynamic> device = response['device'];
        _sub_login = device['sub_login'];
        _auth_key = device['authentication_key'];
        _aor = device['aor'];

        softphone.register(device['sub_login'], device['authentication_key'],
            device['aor'].replaceAll('sip:', ''));
      });
    }
  }

  int _currentIndex = 1;

  void onTabTapped(int index) {
    this.setState(() {
      _currentIndex = index;
    });
  }

  void _openDialPad() {
    showBarModalBottomSheet(context: context, builder: (context) => DialPad());
  }

  void _openCallView() {
    this.setState(() {
      _callInProgress = !_callInProgress;
    });
  }

  _openNewMessage() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => NewMessagePopup(fusionConnection));
  }

  void _loginSuccess(String username, String password) {
    this.setState(() {
      _logged_in = true;
    });
  }

  _getFloatingButton() {
    if (_currentIndex <= 1) {
      return FloatingActionButton(
        onPressed: _openDialPad,
        backgroundColor: crimsonLight,
        foregroundColor: Colors.white,
        child: Icon(Icons.dialpad),
      );
    } else if (_currentIndex == 2) {
      return FloatingActionButton(
        backgroundColor: crimsonLight,
        foregroundColor: Colors.white,
        onPressed: _openNewMessage,
        child: Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

  _getTabWidget() {
    return (_currentIndex == 0
        ? RecentContactsTab(fusionConnection)
        : (_currentIndex == 1
            ? TextButton(onPressed: _openCallView, child: Text('open call'))
            : MessagesTab(fusionConnection)));
  }

  @override
  Widget build(BuildContext context) {
    if (!_logged_in) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/fill.jpg"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: bgBlend,
              body:
                  SafeArea(child: LoginView(_loginSuccess, fusionConnection))));
    }

    if (_callInProgress == true) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                bottom: false, child: CallView(closeView: _openCallView)),
          ));
    }

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fill.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          drawer: Menu(fusionConnection),
          backgroundColor: bgBlend,
          body: SafeArea(
            child: _getTabWidget(),
          ),
          floatingActionButton: _getFloatingButton(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(CupertinoIcons.person_2),
                label: "People",
              ),
              BottomNavigationBarItem(
                icon: new Icon(CupertinoIcons.phone_solid),
                label: "Call TEST",
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble), label: 'Messages')
            ],
          ),
        ));
  }
}
