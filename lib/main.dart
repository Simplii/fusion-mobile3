import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:all_sensors/all_sensors.dart';
import 'package:callkeep/callkeep.dart';
import 'package:flutter/services.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apns/flutter_apns.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_view.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

import 'src/backend/fusion_connection.dart';
import 'src/backend/softphone.dart';
import 'src/calls/recent_calls.dart';
import 'src/components/menu.dart';
import 'src/contacts/recent_contacts.dart';
import 'src/login.dart';
import 'src/messages/messages_list.dart';
import 'src/messages/new_message_popup.dart';
import 'src/messages/sms_conversation_view.dart';
import 'src/styles.dart';
import 'src/utils.dart';

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
  });
  return flutterLocalNotificationsPlugin;
}

Future<dynamic> backgroundMessageHandler(RemoteMessage message) {
  print('backgroundMessage: message => ${message.toString()}');
  print('backgroundMessage: message => ${message.data.toString()}');

  var data = message.data;

  if (data.containsKey("remove_fusion_call")) {
    final callUUID = uuidFromString(data['call_id']);
    var id = intIdForString(data['call_id']);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        registerNotifications();

    flutterLocalNotificationsPlugin.cancel(id);
    }

  if (data.containsKey("fusion_call") && data['fusion_call'] == "true") {
    var callerName = data['caller_id'] as String;
    var callerNumber = data['caller_number'] as String;
    final callUUID = uuidFromString(data['call_id']);
    var id = intIdForString(data['call_id']);
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
    print("showing notification");
    print(id);
    print(data);
    flutterLocalNotificationsPlugin.show(id, callerName,
       callerNumber + ' incoming phone call', platformChannelSpecifics,
        payload: callUUID.toString());

    var timer = Timer(Duration(seconds: 40),
            () {
              flutterLocalNotificationsPlugin.cancel(id);
            });
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler); // }

  registerNotifications();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await SentryFlutter.init(
    (options) => options.dsn =
        'https://91be6ab841f64100a3698952bbc577c2@o68456.ingest.sentry.io/6019626',
    appRunner: () => runApp(MaterialApp(home: MyApp())),
  );
   // runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  FusionConnection _fusionConnection;
  Softphone _softphone;
  RemoteMessage _launchMessage;

  MyApp() {
    _fusionConnection = FusionConnection();
    _softphone = Softphone(_fusionConnection);
    _fusionConnection.setSoftphone(_softphone);

    getApplicationDocumentsDirectory().then((Directory directory) {
      print("got app dir gotappdir");
      print(directory.absolute);
      print(directory.listSync(recursive: true, followLinks: false));
    });
  }

  bool _listenerHasBeenSetup = false;

  _setupListener() async {}

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
  MyHomePage({Key key, this.title, this.softphone, this.fusionConnection, this.launchMessage})
      : super(key: key);
  final Softphone softphone;
  final FusionConnection fusionConnection;
  final String title;
  final RemoteMessage launchMessage;

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
  RemoteMessage _launchMessage;
  bool _isRegistering = false;
  bool _logged_in = false;
  bool _callInProgress = false;
  bool _isInProximity;
  bool _isProximityListening = false;
  StreamSubscription<ProximityEvent> _proximitySub;

  _logOut() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    this.setState(() {
      _isRegistering = false;
      _sub_login = "";
      _aor = "";
      _auth_key = "";
      _callInProgress = false;
      _logged_in = false;
    });
  }

  @override
  initState() {
    super.initState();
    receivedMsg = "";
    fusionConnection.onLogOut(_logOut);
    softphone.onUpdate(() {
      setState(() {});
    });
    _autoLogin();

    final connector = createPushConnector();
    connector.configure(
        onLaunch: _onLaunch, onResume: _onResume, onMessage: _onMessage);
    fusionConnection.setAPNSConnector(connector);
    _setupPermissions();
    _setupFirebase();
  }

  _setupPermissions() {
    print("gonna get permissions");
    [
      Permission.phone,
      Permission.bluetoothConnect,
      Permission.bluetooth,
    ].request().then((Map<Permission, PermissionStatus> statuses) {
      print('status1 permission');
      print(statuses[Permission.phone]);
      print('status2 permission');
      print(statuses[Permission.bluetooth]);
      print('status3 permission');
      print(statuses[Permission.bluetoothConnect]);
    });

  }

  Future<void> _onLaunch(RemoteMessage m) {
    _launchMessage = m;
  }

  Future<void> _onResume(RemoteMessage m) {
    softphone.reregister();
  }

  Future<void> _onMessage(RemoteMessage m) {
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage == null && _launchMessage != null) {
      initialMessage = _launchMessage;
      _launchMessage = null;
    }

    if (initialMessage != null) {
      checkForIMNotification(initialMessage.data);
    }
  }

  checkForIMNotification(Map<String, dynamic> data) {
    if (data.containsKey('to_number')) {
      fusionConnection.contacts.search(data['from_number'], 10, 0,
          (contacts, fromServer) {
        if (fromServer) {
          fusionConnection.integratedContacts.search(
              data['from_number'], 10, 0, (crmContacts, fromServer, hasMore) {
            if (fromServer) {
              contacts.addAll(crmContacts);
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => SMSConversationView(
                      fusionConnection,
                      softphone,
                      SMSConversation.build(
                          contacts: contacts,
                          crmContacts: [],
                          myNumber: data['to_number'],
                          number: data['from_number'])));
            }
          });
        }
      });
    }
  }

  _setupFirebase() {
    FirebaseMessaging.onMessage.listen((event) {
      print("gotfbmessage:" + event.data.toString());
      event.data;
      setState(() {
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("gotfbmessageandopened:" + event.data.toString());
      checkForIMNotification(event.data);
    });
  }

  _autoLogin() {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      String username = prefs.getString("username");
      String domain = username.split('@')[1];
      String sub_login = prefs.getString("sub_login");
      String aor = prefs.getString("aor");
      String auth_key = prefs.getString("auth_key");

      if (auth_key != null && auth_key != "") {
        fusionConnection.autoLogin(username, domain);
        setState(() {
          _sub_login = sub_login;
          _auth_key = auth_key;
          _aor = aor;
          _logged_in = true;
          _isRegistering = true;
        });

        softphone.register(sub_login, auth_key, aor.replaceAll('sip:', ''));
        checkForInitialMessage();
      } else {
      }
    });
  }

  Future<void> _register() async {
    if (_isRegistering) {
      return;
    } else if (_sub_login != "") {
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

        SharedPreferences.getInstance().then((SharedPreferences prefs) {
          prefs.setString("sub_login", _sub_login);
          prefs.setString("auth_key", _auth_key);
          prefs.setString("aor", _aor);
        });

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
    checkForInitialMessage();
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
    if (softphone.activeCall != null && !_isProximityListening) {
      _isProximityListening = true;
      _proximitySub = proximityEvents.listen((ProximityEvent event) {
        setState(() {
          // event.getValue return true or false
          _isInProximity = event.getValue();
        });
      });
    } else if (softphone.activeCall == null && _isProximityListening) {
      _proximitySub.cancel();
    }

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
        child: Stack(
            children: [Scaffold(
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
                          label: "Calls (" + (softphone.helper.connected ? "C" :"c") + (softphone.helper.registered ? "R" : "r") + ")",
                        ),
                        BottomNavigationBarItem(
                          icon: Opacity(
                              child: Image.asset("assets/icons/people.png",
                                  width: 18, height: 18),
                              opacity: 0.5),
                          activeIcon: Image.asset("assets/icons/people.png",
                              width: 18, height: 18),
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
                ))),
              if (softphone.activeCall != null && _isInProximity)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red
                  ),
                    width:   MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height
                )
            ]));
  }
}
