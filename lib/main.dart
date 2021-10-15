import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:callkeep/callkeep.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apns/flutter_apns.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_view.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:uuid/uuid.dart';

import 'src/backend/fusion_connection.dart';
import 'src/backend/softphone.dart';
import 'src/calls/recent_calls.dart';
import 'src/components/menu.dart';
import 'src/contacts/recent_contacts.dart';
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

registerNotifications() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon_background');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification:
              (int i, String a, String b, String s) {});
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String s) {
    print("gotonoticication" + s);
  });
  return flutterLocalNotificationsPlugin;
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Fusion Notifications',
        channelDescription: 'Notification channel for incoming calls',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ]);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

Future<dynamic> backgroundMessageHandler(RemoteMessage message) {
  print('backgroundMessage: message => ${message.toString()}');
  print('backgroundMessage: message => ${message.data.toString()}');

  var data = message.data;

  if (data.containsKey("alert") && data['alert'] == "call") {
    var callerName = data['phonenumber'] as String;
    final callUUID = Uuid().v4();

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        registerNotifications();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('fusion', 'Fusion calls',
            channelDescription: 'Fusion incoming calls',
            importance: Importance.max,
            fullScreenIntent: true,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        0, callerName, 'Incoming phone call', platformChannelSpecifics,
        payload: callUUID.toString());

    /*AwesomeNotifications().createNotification(
      content: NotificationContent(

          id: 0,
          channelKey: 'basic_channel',
          title: callerName,
          body: 'Incoming call',
        showWhen: true,
        autoCancel: true,
        notificationLayout: NotificationLayout.BigText
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'accept',
          label: 'Answer',
        ),
        NotificationActionButton(
          key: 'cancel',
          label: 'Decline',
        ),
      ],
    );

    AwesomeNotifications().actionStream.listen((event) {
      print("gotevent" + event.toString());
    });
*/
    if (false) {
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
              'notificationIcon':
                  'Path to the resource icon of the notification',
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
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler); // }
  //else {
//     Firebase.initializeApp();
//  }
  registerNotifications();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  FusionConnection _fusionConnection;
  Softphone _softphone;

  MyApp() {
    this._fusionConnection = FusionConnection();
    this._softphone = Softphone(_fusionConnection);

    final connector = createPushConnector();
    connector.configure(
        onLaunch: _onLaunch, onResume: _onResume, onMessage: _onMessage);

    _fusionConnection.setAPNSConnector(connector);
  }

  Future<void> _onLaunch(RemoteMessage m) {
    print("onloaunch");
  }

  Future<void> _onResume(RemoteMessage m) {
    print("onresume");
  }

  Future<void> _onMessage(RemoteMessage m) {
    print("onmessage");
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
        'domain': fusionConnection.getDomain(),
        'device':
            'sip:${fusionConnection.getExtension()}fm@${fusionConnection.getDomain()}',
        'user': fusionConnection.getExtension()
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

  int _currentIndex = 0;

  void onTabTapped(int index) {
    this.setState(() {
      _currentIndex = index;
    });
  }

  void _openDialPad() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => DialPadModal(fusionConnection, softphone));
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
        builder: (context) => NewMessagePopup(fusionConnection, softphone));
  }

  void _loginSuccess(String username, String password) {
    this.setState(() {
      _logged_in = true;
    });
    _register();
  }

  _getFloatingButton() {
    if (_currentIndex == 0) {
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
        ? RecentCallsTab(fusionConnection, softphone)
        : (_currentIndex == 1
            ? RecentContactsTab(fusionConnection, softphone)
            : MessagesTab(fusionConnection, softphone)));
  }

  @override
  Widget build(BuildContext context) {
    if (!_logged_in) {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/fill.jpg"), fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: bgBlend,
              body:
                  SafeArea(child: LoginView(_loginSuccess, fusionConnection))));
    }

    if (softphone.activeCall != null) {
      return CallView(fusionConnection, softphone, closeView: _openCallView);
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
            bottomNavigationBar: Container(
                height: Platform.isAndroid ? 60 : 60.0,
                margin: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                          child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                  color: _currentIndex == 0
                                      ? crimsonLight
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  )))),
                      Expanded(
                          child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                  color: _currentIndex == 1
                                      ? crimsonLight
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  )))),
                      Expanded(
                          child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                  color: _currentIndex == 2
                                      ? crimsonLight
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  )))),
                    ]),
                    BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: smoke,
                      onTap: onTabTapped,
                      currentIndex: _currentIndex,
                      iconSize: 20,
                      selectedLabelStyle: TextStyle(
                          height: 1.8,
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                      unselectedLabelStyle: TextStyle(
                          height: 1.8,
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset("assets/icons/phone_btmbar.png",
                              width: 18, height: 18),
                          activeIcon: Image.asset(
                              "assets/icons/phone_filled_white.png",
                              width: 18,
                              height: 18),
                          label: "Calls",
                        ),
                        BottomNavigationBarItem(
                          icon: Opacity(child: Image.asset("assets/icons/people.png",
                              width: 18, height: 18), opacity: 0.5),
                          activeIcon: Image.asset(
                              "assets/icons/people.png",
                              width: 18,
                              height: 18),
                          label: "People",
                        ),
                        BottomNavigationBarItem(
                            icon: Image.asset("assets/icons/message_btmbar.png",
                                width: 18, height: 18),
                            activeIcon: Image.asset(
                                "assets/icons/message_filled_white.png",
                                width: 18,
                                height: 18),
                            label: 'Messages')
                      ],
                    )
                  ],
                ))));
  }
}
