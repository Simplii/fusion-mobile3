import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';

import '../backend/fusion_connection.dart';
import '../utils.dart';
import 'carbon_date.dart';
import 'contact.dart';
import 'conversations.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'fusion_store.dart';
import 'dart:convert' as convert;

class SMSMessage extends FusionModel {
  bool convertedMms;
  String domain;
  String from;
  bool fromMe;
  String id;
  bool isGroup;
  bool media;
  String message;
  String messageStatus;
  String mime;
  bool read;
  CarbonDate scheduledAt;
  int smsWebhookId;
  CarbonDate time;
  String to;
  String type;
  int unixtime;
  String user;

  SMSMessage(Map<String, dynamic> map) {
    Map<String, dynamic> timeDateObj = checkDateObj(map['time']);
    this.convertedMms = map.containsKey('converted_mms') ? true : false;
    this.domain = map['domain'].runtimeType == String ? map['domain'] : null;
    this.from = map['from'];
    this.fromMe = map['from_me'];
    this.id = map['id'].toString();
    this.isGroup = map['is_group'];
    //this.media = map['media'];
    this.message = map['message'];
    this.messageStatus = map['message_status'];
    this.mime = map['mime'];
    this.read = map['read'] == "1";
    this.scheduledAt = ((map.containsKey('scheduled_at') &&
            map['scheduled_at'].runtimeType == Map)
        ? CarbonDate(map['scheduled_at'])
        : null);
    this.smsWebhookId =
        map['sms_webhook_id'].runtimeType == int ? map['sms_webhook_id'] : 0;
    this.time = CarbonDate(timeDateObj);
    this.to = map['to'];
    this.type = map['type'];
    this.unixtime = map['unixtime'];
    this.user = map['user'].runtimeType == String ? map['user'] : null;
  }

  SMSMessage.fromV2(Map<String, dynamic> map) {
    this.convertedMms = map.containsKey('converted_mms') ? true : false;
    this.domain = map['domain'].runtimeType == String ? map['domain'] : null;
    this.from = map['from'];
    this.fromMe = map['fromMe'];
    this.id = map['id'].toString();
    this.isGroup = map['isGroup'];
    this.message = map['message'];
    this.messageStatus = map['status'];
    this.mime = map['mime'];
    this.read = map['read'];
    this.scheduledAt = ((map.containsKey('scheduledAt') &&
            map['scheduledAt'].runtimeType == Map)
        ? CarbonDate(map['scheduledAt'])
        : null);
    this.smsWebhookId =
        map['smsWebhookId'].runtimeType == int ? map['smsWebhookId'] : 0;
    this.time = CarbonDate.fromDate(map['time']);
    this.to = map['to'];
    this.type = "sms";
    this.unixtime = (DateTime.parse(map['time']).millisecondsSinceEpoch / 1000) as int;
    this.user = map['user'].runtimeType == String ? map['user']
        .toString()
        .replaceFirst(RegExp("@.*"), "") : null;
  }

  serialize() {
    return convert.jsonEncode({
      'convertedMms': convertedMms,
      'domain': domain,
      'from': from,
      'fromMe': fromMe,
      'id': id,
      'isGroup': isGroup,
      'media': media,
      'message': message,
      'messageStatus': messageStatus,
      'mime': mime,
      'read': read,
      'scheduledAt': scheduledAt != null ? scheduledAt.serialize() : null,
      'smsWebhookId': smsWebhookId,
      'time': time.serialize(),
      'to': to,
      'type': type,
      'unixtime': unixtime,
      'user': user,
    });
  }

  SMSMessage.unserialize(String data) {
    Map<String, dynamic> obj = convert.jsonDecode(data);
    this.convertedMms = obj['convertedMms'];
    this.domain = obj['domain'];
    this.from = obj['from'];
    this.fromMe = obj['fromMe'];
    this.id = obj['id'];
    this.isGroup = obj['isGroup'];
    this.media = obj['media'];
    this.message = obj['message'];
    this.messageStatus = obj['messageStatus'];
    this.mime = obj['mime'];
    this.read = obj['read'];
    if (obj['scheduledAt'] != null)
      this.scheduledAt = CarbonDate.unserialize(obj['scheduledAt']);
    this.smsWebhookId = obj['smsWebhookId'];
    if (obj['time'] != null) this.time = CarbonDate.unserialize(obj['time']);
    this.to = obj['to'];
    this.type = obj['type'];
    this.unixtime = obj['unixtime'];
    this.user = obj['user'];
  }

  @override
  String getId() => this.id.toLowerCase();
}

class SMSMessageSubscription {
  final SMSConversation _conversation;
  final Function(List<SMSMessage>) _callback;

  SMSMessageSubscription(this._conversation, this._callback);

  testMatches(SMSMessage message) {
    return ((message.from == _conversation.number &&
            message.to == _conversation.myNumber) ||
        (message.to == _conversation.number &&
            message.from == _conversation.myNumber));
  }

  sendMatching(List<SMSMessage> items) {
    List<SMSMessage> list = [];

    for (SMSMessage item in items) {
      if (testMatches(item)) {
        list.add(item);
      }
    }

    this._callback(list);
  }
}

class SMSMessagesStore extends FusionStore<SMSMessage> {
  String _id_field = 'id';
  Map<String, SMSMessageSubscription> subscriptions = {};
  Map<String, bool> notifiedMessages = {};

  SMSMessagesStore(FusionConnection _fusionConnection)
      : super(_fusionConnection);

  notifyMessage(SMSMessage message) {
    if (!notifiedMessages.containsKey(message.id)) {
      notifiedMessages[message.id] = true;

      fusionConnection.callpopInfos.lookupPhone(message.from, (callpopInfo) {
          String name = message.from.toString().formatPhone();
          callpopInfo.contacts.map((e) {
            name = e.name;
          });
print("willshowinfo");
print(name);
print(message);
print(callpopInfo);
          showSimpleNotification(
                Text(name + " says: " + message.message),
                background: smoke);
      });

      new Future.delayed(Duration(minutes: 2), () {
        notifiedMessages.remove(message.id);
      });
    }
  }

  subscribe(SMSConversation conversation, Function(List<SMSMessage>) callback) {
    String name = randomString(20);
    subscriptions[name] = SMSMessageSubscription(conversation, callback);
    return name;
  }

  persist(SMSMessage record) {
    fusionConnection.db
        .delete('sms_message', where: 'id = ?', whereArgs: [record.getId()]);
    fusionConnection.db.insert('sms_message', {
      'id': record.getId(),
      'from': record.from,
      'fromMe': record.fromMe != null && record.fromMe ? 1 : 0,
      'media': record.media != null && record.media ? 1 : 0,
      'message': record.message,
      'mime': record.mime,
      'read': record.read != null && record.read ? 1 : 0,
      'time': record.unixtime,
      'to': record.to,
      'user': record.user,
      'raw': record.serialize()
    });
  }

  clearSubscription(name) {
    if (subscriptions.containsKey(name)) {
      subscriptions.remove(name);
    }
  }

  @override
  storeRecord(SMSMessage message) {
    super.storeRecord(message);

    for (SMSMessageSubscription subscription in subscriptions.values) {
      subscription.sendMatching([message]);
    }

    persist(message);
  }

  sendMediaMessage(XFile file, SMSConversation conversation) async {
    fusionConnection.apiV1Multipart("POST", "/chat/send_sms", {
      'number': conversation.myNumber,
      'schedule': 'false',
      'is_mms': 'true',
      'from': conversation.myNumber,
      'is_message': 'true',
      'to': conversation.number,
      'from_me': 'true',
      'destination': conversation.number,
      'message': ""
    }, [
      http.MultipartFile.fromBytes(
          "file",
          await file.readAsBytes(),
          filename: basename(file.path),
          contentType: MediaType.parse(lookupMimeType(file.path)))
    ], callback: (Map<String, dynamic> data) {

      SMSMessage message = SMSMessage(data);
      storeRecord(message);
    });
  }

  sendMessage(String text, SMSConversation conversation) {
    fusionConnection.apiV1Call("post", "/chat/send_sms", {
      'number': conversation.myNumber,
      'schedule': null,
      'is_mms': false,
      'from': conversation.myNumber,
      'is_message': true,
      'to': conversation.number,
      'from_me': true,
      'destination': conversation.number,
      'message': text,
      'is_group': false
    }, callback: (Map<String, dynamic> data) {
      SMSMessage message = SMSMessage(data);
      storeRecord(message);
    });
  }

  search(
      String query,
      Function(List<SMSConversation> conversations,
              List<CrmContact> crmContacts, List<Contact> Contacts)
          callback) {
    if (query.trim().length == 0) {
      return;
    }

    List<SMSConversation> matchedConversations = [];
    List<CrmContact> matchedCrmContacts = [];
    List<Contact> matchedContacts = [];

    Function() _sendFromPersisted = () {
      callback(matchedConversations, matchedCrmContacts, matchedContacts);
    };

    fusionConnection.conversations.searchPersisted(query, "-2", 100, 0,
        (List<SMSConversation> convos, fromHttp) {
      matchedConversations = convos;
      _sendFromPersisted();
    });

    fusionConnection.contacts.searchPersisted(query, 100, 0,
        (List<Contact> contacts, bool fromServer) {
      matchedContacts = contacts;
      _sendFromPersisted();
    });

    fusionConnection.apiV1Call("get", "/chat/search/flat", {
      'query': query,
      'my_numbers': "8014569812",
    }, callback: (Map<String, dynamic> data) {
      Map<String, Contact> contacts = {};
      Map<String, CrmContact> crmContacts = {};
      Map<String, SMSMessage> messages = {};
      Map<String, SMSConversation> conversations = {};

      for (Map<String, dynamic> item in data['agg']['contacts']) {
        contacts[item['id']] = Contact(item);
      }

      for (Map<String, dynamic> item in data['agg']['leads']) {
        crmContacts[item['id'].toString()] = CrmContact.fromExpanded(item);
      }

      Map<String, dynamic> convoslist = {};

      if (data['agg']['conversations'] is List<dynamic>) {
        convoslist = {};//data['agg']['conversations'];
      }

      for (String key in convoslist.keys) {
        List<Contact> contactsList =
            (convoslist[key]['contacts'] as List<dynamic>).map((dynamic i) {
          return contacts[i.toString()];
        }).toList();
        List<CrmContact> leadsList =
            (convoslist[key]['leads'] as List<dynamic>).map((dynamic i) {
          return crmContacts[i.toString()];
        }).toList();

        Map<String, dynamic> item = convoslist[key];
        item['leads'] = leadsList;
        item['contacts'] = contactsList;
        item['number'] = item['their_number'];
        SMSConversation convo = SMSConversation(item);
        conversations[key] = convo;
      }

      List<SMSConversation> fullConversations = [];
      for (Map<String, dynamic> item in data['items']) {
        SMSMessage message = SMSMessage(item);
        if (item['conversation_id'] != null && conversations.containsKey(item['conversation_id'])) {
          SMSConversation convo = conversations[item['conversation_id']];
          SMSConversation newConvo = SMSConversation.copy(convo);
          newConvo.message = message;
          fullConversations.add(newConvo);
        }
      }

      callback(fullConversations, crmContacts.values.toList(),
          contacts.values.toList());
    });
  }

  getPersisted(SMSConversation convo, int limit, int offset,
      Function(List<SMSMessage>, bool) callback) {
    fusionConnection.db.query('sms_message',
        limit: limit,
        offset: offset,
        where: '(`to` = ? and `from` = ?) or (`from` = ? and `to` = ?)',
        orderBy: "id desc",
        whereArgs: [
          convo.myNumber,
          convo.number,
          convo.myNumber,
          convo.number
        ]).then((List<Map<String, dynamic>> results) {
      List<SMSMessage> list = [];
      for (Map<String, dynamic> result in results) {
        list.add(SMSMessage.unserialize(result['raw']));
      }
      callback(list, false);
    });
  }

  getMessages(SMSConversation convo, int limit, int offset,
      Function(List<SMSMessage> messages, bool fromServer) callback) {
    getPersisted(convo, limit, offset, callback);
    fusionConnection.apiV1Call("get", "/chat/conversation/messages", {
      'my_numbers': convo.myNumber,
      'their_numbers': convo.number,
      'limit': limit,
      'offset': offset,
      'group_id': -2
    }, callback: (Map<String, dynamic> data) {
      List<SMSMessage> messages = [];

      for (Map<String, dynamic> item in data['items']) {
        SMSMessage message = SMSMessage(item);
        storeRecord(message);
        messages.add(message);
      }
      callback(messages, true);
    });
  }

  void deleteMessage(String id) {
    print("here123 ${id}");
    fusionConnection.apiV1Call("post", "/chat/hide_message", {
      "message_ids": [id],
    }, callback: (res) {
      print('here123 ${res}');
    });
  }
}
