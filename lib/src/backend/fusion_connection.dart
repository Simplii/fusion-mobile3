import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_apns/src/connector.dart';
import 'package:fusion_mobile_revamped/src/models/contact_fields.dart';
import 'package:fusion_mobile_revamped/src/models/park_lines.dart';
import 'package:fusion_mobile_revamped/src/models/timeline_items.dart';
import 'package:fusion_mobile_revamped/src/models/voicemails.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/integrated_contacts.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:fusion_mobile_revamped/src/models/user_settings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_manager/websocket_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../utils.dart';
import 'softphone.dart';

class FusionConnection {
  String _extension = '';
  String _username = '';
  String _password = '';
  String _domain = '';
  Map<String, bool> _heartbeats = {};
  CrmContactsStore crmContacts;
  ContactsStore contacts;
  CallpopInfoStore callpopInfos;
  WebsocketManager _socket;
  SMSConversationsStore conversations;
  SMSMessagesStore messages;
  UserSettings settings;
  SMSDepartmentsStore smsDepartments;
  CallHistoryStore callHistory;
  CoworkerStore coworkers;
  IntegratedContactsStore integratedContacts;
  ContactFieldStore contactFields;
  TimelineItemStore timelineItems;
  ParkLineStore parkLines;
  VoicemailStore voicemails;
  Database db;
  PushConnector _connector;
  String _pushkitToken;
  Softphone _softphone;
  PersistCookieJar _cookies;
  Function _onLogOut = () {};

  String serverRoot = "http://fusioncomm.net";
  String defaultAvatar = "https://fusioncomm.net/img/fa-user.png";

  FusionConnection() {
    crmContacts = CrmContactsStore(this);
    integratedContacts = IntegratedContactsStore(this);
    contacts = ContactsStore(this);
    callpopInfos = CallpopInfoStore(this);
    conversations = SMSConversationsStore(this);
    messages = SMSMessagesStore(this);
    settings = UserSettings(this);
    smsDepartments = SMSDepartmentsStore(this);
    callHistory = CallHistoryStore(this);
    coworkers = CoworkerStore(this);
    timelineItems = TimelineItemStore(this);
    contactFields = ContactFieldStore(this);
    voicemails = VoicemailStore(this);
    parkLines = ParkLineStore(this);
    contactFields.getFields((List<ContactField> list, bool fromServer) {});
    getDatabase();
    _getCookies();
  }

  _getCookies() {
    getApplicationDocumentsDirectory().then((directory) {
      _cookies = PersistCookieJar(
          ignoreExpires: true, storage: FileStorage(directory.path));
    });
  }

  setSoftphone(Softphone softphone) {
    _softphone = softphone;
  }

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://fusioncomm.net:8443'),
  );

  onLogOut(Function callback) {
    _onLogOut = callback;
  }

  setPushkitToken(String token) {
    _pushkitToken = token;
  }

  logOut() {
    _onLogOut();
    apiV1Call("get", "/log_out", {}, callback: (data) {});
    FirebaseMessaging.instance.getToken().then((token) {
      apiV1Call(
        "delete",
        "/clients/device_token",
        {"token": token, "pn_tok": _pushkitToken},
      );
    });
  }

  getDatabase() {
    print("gettingdatabase");
    getDatabasesPath().then((String path) {
      openDatabase(p.join(path, "fusion.db"), version: 1, onOpen: (db) {
        print("executing");
        print(db.execute('''
          CREATE TABLE IF NOT EXISTS sms_conversation(
          id TEXT PRIMARY key,
          groupName TEXT,
          isGroup int,
          lastContactTime int,
          searchString TEXT,
          number TEXT,
          myNumber TEXT,
          unread int,
          raw BLOB
          );'''));

        print(db.execute('''
          CREATE TABLE IF NOT EXISTS sms_message(
          id TEXT PRIMARY key,
          `from` TEXT,
          fromMe int,
          media int,
          message TEXT,
          mime TEXT,
          read int,
          time int,
          `to` STRING,
          user STRING,
          raw BLOB
          );'''));

        print(db.execute('''
          CREATE TABLE IF NOT EXISTS contacts(
          id TEXT PRIMARY key,
          company TEXT,
          deleted int,
          searchString TEXT,
          firstName TEXT,
          lastName TEXT,
          raw BLOB
          );
          '''));
      }).then((Database db) {
        print("gotdatabase" + db.toString());
        this.db = db;
      }).catchError((error) {
        print("databasegettingerror" + error.toString());
      });
    });
  }

  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  _saveCookie(Response response) {
    if (response.headers.containsKey('set-cookie')) {
      Cookie cookie = Cookie.fromSetCookieValue(response.headers['set-cookie']);
      _cookies.saveFromResponse(response.request.url, [cookie]);
    }
  }

  _cookieHeaders(url) async {
    List<Cookie> cookies = await _cookies.loadForRequest(url);
    String cookiesHeader = "";
    Map<String, String> headers = {};

    for (Cookie c in cookies) {
      cookiesHeader += c.name + "=" + c.value + "; ";
    }
    print("cookeis header:" + cookiesHeader);
    headers['cookie'] = cookiesHeader;
    return headers;
  }

  nsApiCall(String object, String action, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
      data['action'] = action;
      data['object'] = object;
      data['username'] = await _getUsername();
      //data['password'] = _password;
      print("cookie");
      Uri url = Uri.parse('https://fusioncomm.net/api/v1/clients/api_request');

      var uriResponse = await client.post(url,
          headers: await _cookieHeaders(url), body: data);

      _saveCookie(uriResponse);
      print("nsapicall:" + uriResponse.headers['set-cookie'].toString());

      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse =
            convert.jsonDecode(uriResponse.body) as Map<String, dynamic>;
      } catch (e) {}
      print("apicall:" + data.toString() + ":" + jsonResponse.toString());
      callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  apiV1Call(String method, String route, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
      print("apiv1:" + data.toString());
      data['username'] = await _getUsername();

      Function fn = {
        'post': client.post,
        'get': client.get,
        'patch': client.patch,
        'put': client.put,
        'delete': client.delete
      }[method.toLowerCase()];

      Map<Symbol, dynamic> args = {};
      String urlParams = '?';
      if (method.toLowerCase() == 'get') {
        for (String key in data.keys) {
          urlParams += key + "=" + data[key].toString() + '&';
        }
      }
      Uri url = Uri.parse('https://fusioncomm.net/api/v1' + route + urlParams);
      Map<String, String> headers = await _cookieHeaders(url);

      if (method.toLowerCase() != 'get') {
        args[#body] = convert.jsonEncode(data);
        headers["Content-Type"] = "application/json";
      }
      args[#headers] = headers;

      print(url);
      print(args);
      print(headers.toString());
      var uriResponse = await Function.apply(fn, [url], args);
      print(uriResponse.body);
      _saveCookie(uriResponse);
      var jsonResponse = convert.jsonDecode(uriResponse.body);
      if (callback != null) callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  apiV2Call(String method, String route, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
      Function fn = {
        'post': client.post,
        'get': client.get,
        'patch': client.patch,
        'put': client.put,
        'delete': client.delete
      }[method.toLowerCase()];

      data['username'] = await _getUsername();
      Map<Symbol, dynamic> args = {};
      String urlParams = '?';

      if (method.toLowerCase() == 'get') {
        for (String key in data.keys) {
          urlParams += key + "=" + data[key].toString() + '&';
        }
      }
      Uri url = Uri.parse('http://fusioncomm.net/api/v2' + route + urlParams);
      Map<String, String> headers = await _cookieHeaders(url);

      if (method.toLowerCase() != 'get') {
        args[#body] = convert.jsonEncode(data);
        headers["Content-Type"] = "application/json";
      }

      args[#headers] = headers;
      print(url);
      var uriResponse = await Function.apply(fn, [url], args);
      _saveCookie(uriResponse);
      var jsonResponse = convert.jsonDecode(uriResponse.body);
      if (callback != null) callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  apiV1Multipart(String method, String route, Map<String, dynamic> data,
      List<http.MultipartFile> files,
      {Function callback}) async {
    var client = http.Client();
    try {
      data['username'] = await _getUsername();

      Uri url = Uri.parse('https://fusioncomm.net/api/v1' + route);
      http.MultipartRequest request = new http.MultipartRequest(method, url);
      _cookieHeaders(url).forEach((k, v) => request.headers[k] = v);

      for (String key in data.keys) {
        request.fields[key] = data[key].toString();
      }

      for (http.MultipartFile file in files) {
        request.files.add(file);
      }

      var uriResponse = await request.send();
      String responseBody =
          await uriResponse.stream.transform(utf8.decoder).join();

      var jsonResponse = convert.jsonDecode(responseBody);

      callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  myAvatarUrl() {
    return settings.myAvatar();
  }

  getUid() {
    return _username;
  }

  getExtension() {
    return _extension;
  }

  getDomain() {
    return _domain;
  }

  login(String username, String password, Function(bool) callback) {
    apiV1Call(
        "get",
        "/clients/lookup_options",
        password != null
            ? {"username": username, "password": password}
            : {"username": username},
        callback: (Map<String, dynamic> response) {
      if (response.containsKey("access_key")) {
        _username = username;
        _password = password;
        _domain = username.split('@')[1];
        _extension = username.split('@')[0];
        settings.setOptions(response);
        settings.lookupSubscriber();
        coworkers.getCoworkers((data) {});
        setupSocket();
        callback(true);

        smsDepartments.getDepartments((List<SMSDepartment> lis) {});

        FirebaseMessaging.instance.getToken().then((token) {
          apiV1Call("post", "/clients/device_token",
              {"token": token, "pn_tok": _pushkitToken});
        });
      } else {
        callback(false);
      }
    });
  }

  _reconnectSocket() {
    _socket.connect().then((val) {
      _socket.send(convert.jsonEncode({
        "simplii_identification": [_extension, _domain],
        "pwd": _password
      }));
    });
  }

  _sendHeartbeat() {
    String beat = randomString(30);
    _sendToSocket({'heartbeat': beat});
    Future.delayed(const Duration(seconds: 15), () {
      if (_heartbeats[beat] != null && !_heartbeats[beat]) {
        _socket.close();
        setupSocket();
      }
      _heartbeats.remove(beat);
      _sendHeartbeat();
    });
  }

  _sendToSocket(Map<String, dynamic> payload) {
    _socket.send(convert.jsonEncode(payload));
  }

  setupSocket() {
    int messageNum = 0;
    _socket = WebsocketManager("wss://fusioncomm.net:8443/");
    _socket.onClose((dynamic message) {
      print('close');
    });
    _socket.onMessage((dynamic messageData) {
      Map<String, dynamic> message = convert.jsonDecode(messageData);

      if (message.containsKey('heartbeat')) {
        _heartbeats[message['heartbeat']] = true;
      } else if (message.containsKey('sms_received')) {
        messages.storeRecord(SMSMessage(message['message_object']));
      } else if (message.containsKey('new_status')) {
        coworkers.storePresence(
            message['user'] + '@' + message['domain'].toString().toLowerCase(),
            message['new_status'],
            message['message']);
      }

      _softphone.checkCallIds(message);
    });
    _reconnectSocket();
    _sendHeartbeat();
  }

  void setAPNSConnector(PushConnector connector) {
    _connector = connector;
  }
}
