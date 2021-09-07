import 'package:flutter/foundation.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:websocket_manager/websocket_manager.dart';


class FusionConnection {
  String _extension = '9812';
  String _username = '9812@Simplii1';
  String _password = '***REMOVED***';
  String _domain = 'Simplii1';
  CrmContactsStore crmContacts;
  ContactsStore contacts;
  CallpopInfoStore callpopInfos;
  WebsocketManager _socket;

  FusionConnection() {
    crmContacts = CrmContactsStore(this);
    contacts = ContactsStore(this);
    callpopInfos = CallpopInfoStore(this);
  }

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://fusioncomm.net:8443'),
  );

  nsApiCall(String object, String action, Map<String, dynamic> data, {Function callback}) async {
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

  apiV1Call(String method, String route, Map<String, dynamic> data, {Function callback}) async {
    var client = http.Client();
    try {
      data['username'] = _username;
      data['password'] = _password;

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
      else {
        args[#body] = data;
      }

      Uri url = Uri.parse('https://fusioncomm.net/api/v1' + route + urlParams);
      var uriResponse = await Function.apply(fn, [url], args);

      print(url);

      var jsonResponse =
        convert.jsonDecode(uriResponse.body) as Map<String, dynamic>;

      callback(jsonResponse);
    } finally {
      client.close();
    }
  }

  setupSocket() {
    int messageNum = 0;
    _socket = WebsocketManager("wss://fusioncomm.net:8443/");
    _socket.onClose((dynamic message) {
      print('close');
    });
    _socket.onMessage((dynamic message) {
    });
    _socket.connect()
        .then((val) {
      _socket.send(convert.jsonEncode({
        "simplii_identification": [
          _extension,
          _domain
        ],
        "pwd": _password
      }));
    });
  }
}