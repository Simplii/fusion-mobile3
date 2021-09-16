import 'dart:convert' as convert;

import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:fusion_mobile_revamped/src/models/user_settings.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_manager/websocket_manager.dart';

import '../utils.dart';

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

  Function _onLogOut = () {};

  String serverRoot = "https://fusioncomm.net";
  String defaultAvatar = "https://fusioncomm.net/img/fa-user.png";

  FusionConnection() {
    crmContacts = CrmContactsStore(this);
    contacts = ContactsStore(this);
    callpopInfos = CallpopInfoStore(this);
    conversations = SMSConversationsStore(this);
    messages = SMSMessagesStore(this);
    settings = UserSettings(this);
    smsDepartments = SMSDepartmentsStore(this);
    callHistory = CallHistoryStore(this);
    coworkers = CoworkerStore(this);
  }

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://fusioncomm.net:8443'),
  );

  onLogOut(Function callback) {
    _onLogOut = callback;
  }

  logOut() {
    _onLogOut();
    apiV1Call("get", "/log_out", {}, callback: (data) {});
  }

  nsApiCall(String object, String action, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
      data['action'] = action;
      data['object'] = object;
      data['username'] = _username;
      data['password'] = _password;

      var uriResponse = await client.post(
          Uri.parse('https://fusioncomm.net/api/v1/clients/api_request'),
          body: data);

      var jsonResponse =
          convert.jsonDecode(uriResponse.body) as Map<String, dynamic>;

      callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  apiV1Call(String method, String route, Map<String, dynamic> data,
      {Function callback}) async {
    var client = http.Client();
    try {
      if (!data.containsKey('username')) {
        data['username'] = _username;
        data['password'] = _password;
      }

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
      } else {
        args[#body] = convert.jsonEncode(data);
        args[#headers] = {"Content-Type": "application/json"};
      }

      Uri url = Uri.parse('https://fusioncomm.net/api/v1' + route + urlParams);
      print(url);
      print(args);
      var uriResponse = await Function.apply(fn, [url], args);

      print(url);

      var jsonResponse =
          convert.jsonDecode(uriResponse.body);

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

  getDomain() {
    return _domain;
  }

  login(String username, String password, Function(bool) callback) {
    apiV1Call("get", "/clients/lookup_options", {
      "username": username,
      "password": password
    }, callback: (Map<String, dynamic> response) {
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
      if (!_heartbeats[beat]) {
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
      print("gotmessage " + messageData.toString());
      if (message.containsKey('heartbeat')) {
        _heartbeats[message['heartbeat']] = true;
      } else if (message.containsKey('sms_received')) {
        print("gotIM" + messageData.toString());
        messages.storeRecord(SMSMessage(message['message_object']));
      } else if (message.containsKey('new_status')) {
        coworkers.storePresence(
            message['user'] + '@' + message['domain'].toString().toLowerCase(),
            message['new_status'],
            message['message']);
      }
    });
    _reconnectSocket();
    _sendHeartbeat();
  }
}
