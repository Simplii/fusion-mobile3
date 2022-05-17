import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_apns/src/connector.dart';
import 'package:fusion_mobile_revamped/src/models/contact_fields.dart';
import 'package:fusion_mobile_revamped/src/models/dids.dart';
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
  DidStore dids;
  Database db;
  PushConnector _connector;
  String _pushkitToken;
  Softphone _softphone;
  PersistCookieJar _cookies;
  Function _onLogOut = () {};

  String serverRoot = "http://fusioncomm.net";
  String defaultAvatar = "https://fusioncomm.net/img/fa-user.png";

  FusionConnection() {
    print("gonna get cookies");
    _getCookies();
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
    dids = DidStore(this);
    contactFields.getFields((List<ContactField> list, bool fromServer) {});
    getDatabase();
  }

  _getCookies({Function callback}) async {
    getApplicationDocumentsDirectory().then((directory) {
      _cookies = PersistCookieJar(
          persistSession: true,
          ignoreExpires: true,
          storage: FileStorage(directory.path)
      );

      print("got cookies");
      print(_cookies.domainCookies);
      print(_cookies.hostCookies);
      print(_cookies.storage.toString());

      if (callback != null) {
        callback();
      }
    }).onError((er, err) {
      print("cookie error");
      print(er);
      print(err);
      callback();
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
    FirebaseMessaging.instance.getToken().then((token) {
      apiV1Call("delete", "/clients/device_token",
          {"token": token, "pn_tok": _pushkitToken}, callback: (data) {
        apiV1Call("get", "/log_out", {}, callback: (data) {
          SharedPreferences.getInstance().then((SharedPreferences prefs) {
            prefs.setString("sub_login", "");
            prefs.setString("auth_key", "");
            prefs.setString("aor", "");
          });
          _username = '';
          _password = '';
          _softphone.stopInbound();
          _softphone.close();
          setSoftphone(null);
          _onLogOut();
          _cookies.deleteAll();
        });
      });
    });
  }

  getDatabase() {
    getDatabasesPath().then((String path) {
      openDatabase(p.join(path, "fusion.db"), version: 1, onOpen: (db) {
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
        this.db = db;
      }).catchError((error) {
      });
    });
  }

  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  _saveCookie(Response response) {
    if (response.headers.containsKey('set-cookie')) {
      List<String> cookieStrings = response.headers['set-cookie'].split("HttpOnly,");
      for (String cookieString in cookieStrings) {
        Cookie cookie = Cookie.fromSetCookieValue(cookieString);
        _cookies.saveFromResponse(response.request.url, [cookie]);
      }
    }
  }

  Future<Map<String, String>> _cookieHeaders(url) async {
    Completer<Map<String, String>> c = new Completer<Map<String, String>>();
    var runIt = () async {
      List<Cookie> cookies = await _cookies.loadForRequest(url);
      String cookiesHeader = "";
      Map<String, String> headers = {};

      for (Cookie c in cookies) {
        cookiesHeader += c.name + "=" + c.value + "; ";
      }
      headers['cookie'] = cookiesHeader;
      c.complete(headers);
    };

    if (_cookies == null) {
      _getCookies(callback: runIt);
    } else {
      runIt();
    }
    return c.future;
  }

  nsApiCall(String object, String action, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
      data['action'] = action;
      data['object'] = object;
      data['username'] = await _getUsername();

      Uri url = Uri.parse(
          'https://fusioncomm.net/api/v1/clients/api_request?username=' +
              data['username']);
      Map<String, String> headers = await _cookieHeaders(url);
      String body = convert.jsonEncode(data);
      headers["Content-Type"] = "application/json";

      var uriResponse = await client.post(url, headers: headers, body: body);
      _saveCookie(uriResponse);
      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse =
            convert.jsonDecode(uriResponse.body) as Map<String, dynamic>;
      } catch (e) {}
      print(url);
      print(jsonResponse);
      client.close();
      callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  apiV1Call(String method, String route, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
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

      var uriResponse = await Function.apply(fn, [url], args);
      _saveCookie(uriResponse);
      print(url);
      print(uriResponse.body);
      print(data);
      print(urlParams);
      var jsonResponse = convert.jsonDecode(uriResponse.body);
      client.close();
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
      Uri url = Uri.parse('https://fusioncomm.net/api/v2' + route + urlParams);
      Map<String, String> headers = await _cookieHeaders(url);

      if (method.toLowerCase() != 'get') {
        args[#body] = convert.jsonEncode(data);
        headers["Content-Type"] = "application/json";
      }

      args[#headers] = headers;
      var uriResponse = await Function.apply(fn, [url], args);
      _saveCookie(uriResponse);
      print("apirequest");
      print(route);
      print(urlParams);
      print(data);
      print(uriResponse.body);
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
      (await _cookieHeaders(url))
          .forEach(
              (k, v) => request.headers[k] = v);

      for (String key in data.keys) {
        request.fields[key] = data[key].toString();
      }

      for (http.MultipartFile file in files) {
        request.files.add(file);
      }

      var uriResponse = await request.send();
      String responseBody =
          await uriResponse.stream.transform(utf8.decoder).join();
print(url);
print(responseBody);
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

  _postLoginSetup(Function(bool) callback) {
    settings.lookupSubscriber();
        coworkers.getCoworkers((data) {});
        setupSocket();

        if (callback != null) {
          callback(true);
        }

        smsDepartments.getDepartments((List<SMSDepartment> lis) {});
print("getting token");
print(_pushkitToken);
        FirebaseMessaging.instance.getToken().then((token) {
          print("got token");
          print(token);
          print(_pushkitToken);
          apiV1Call("post", "/clients/device_token",
              {"token": token, "pn_tok": _pushkitToken});
        });
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
        _username = username.split('@')[0] + '@' + response['domain'];

        SharedPreferences.getInstance().then((SharedPreferences prefs) {
          prefs.setString("username", _username);
        });

        _username = _username;
        _password = password;
        _domain = _username.split('@')[1];
        _extension = _username.split('@')[0];
        settings.setOptions(response);
        _postLoginSetup(callback);
      } else {
        callback(false);
      }
    });
  }

  _reconnectSocket() {
    _socket.connect().then((val) {

      print("connection socket");
      print(convert.jsonEncode({
        "simplii_identification": [_extension, _domain],
        "pwd": _password
      }));
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
    });
    _socket.onMessage((dynamic messageData) {
      Map<String, dynamic> message = convert.jsonDecode(messageData);
      print("gotmessage" + message.toString());
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

      if (_softphone != null)
        _softphone.checkCallIds(message);
    });
    _reconnectSocket();
    _sendHeartbeat();
  }

  void setAPNSConnector(PushConnector connector) {
    _connector = connector;
  }

  void autoLogin(String username, String domain) {
    _domain = domain;
    _username = username.split('@')[0] + '@' + domain;
    _domain = _username.split('@')[1];
    _extension = _username.split('@')[0];

    apiV1Call(
        "get",
        "/clients/lookup_options",
        {"username": username},
        callback: (Map<String, dynamic> response) {
          if (response.containsKey("access_key")) {
            settings.setOptions(response);
          }
          else {
            logOut();
          }
        });

    _postLoginSetup((bool success) {});
  }
}
