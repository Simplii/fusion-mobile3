import 'carbon_date.dart';
import 'contact.dart';
import 'conversations.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import '../backend/fusion_connection.dart';
import 'fusion_store.dart';
import '../utils.dart';

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
    this.convertedMms = map.containsKey('converted_mms') ? true : false;
    this.domain = map['domain'].runtimeType == String ? map['domain'] : null;
    this.from = map['from'];
    this.fromMe = map['from_me'];
    this.id = map['id'].toString();
    this.isGroup = map['is_group'];
    this.media = map['media'];
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
    this.time = CarbonDate(map['time']);
    this.to = map['to'];
    this.type = map['type'];
    this.unixtime = map['unixtime'];
    this.user = map['user'].runtimeType == String ? map['user'] : null;
  }
}

class SMSMessageSubscription {
  final SMSConversation _conversation;
  final Function(List<SMSMessage>) _callback;

  SMSMessageSubscription(this._conversation, this._callback);

  testMatches(SMSMessage message) {
    print("subscription test" +
        message.from +
        " " +
        message.to +
        " / " +
        _conversation.number +
        " " +
        _conversation.myNumber);
    return ((message.from == _conversation.number &&
            message.to == _conversation.myNumber) ||
        (message.to == _conversation.number &&
            message.from == _conversation.myNumber));
  }

  sendMatching(List<SMSMessage> items) {
    List<SMSMessage> list = [];
    print("send matching" + items.toString());
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

  SMSMessagesStore(FusionConnection _fusionConnection)
      : super(_fusionConnection);

  subscribe(SMSConversation conversation, Function(List<SMSMessage>) callback) {
    String name = randomString(20);
    subscriptions[name] = SMSMessageSubscription(conversation, callback);
    return name;
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
      Function(
          List<SMSConversation> conversations,
          List<CrmContact> crmContacts,
          List<Contact> Contacts) callback) {
    if (query.trim().length == 0) {
      return;
    }

    fusionConnection.apiV1Call(
        "get",
        "/chat/search/flat", {
        'query': query,
        'my_numbers': "8014569812",
        },
        callback: (Map<String, dynamic> data)
        {
          print(data);
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

          if (data['agg']['conversations'].runtimeType != List) {
            convoslist = data['agg']['conversations'];
          }

          for (String key in convoslist.keys) {
            List<Contact> contactsList = (convoslist[key]['contacts'] as List<dynamic>)
                .sublist(0, 10)
                .map((dynamic i) {
                  return contacts[i.toString()];
            }).toList();
            List<CrmContact> leadsList = (convoslist[key]['leads'] as List<dynamic>)
                .sublist(0, 10)
                .map((dynamic i) {
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
            SMSConversation convo = conversations[item['conversation_id']];
            SMSConversation newConvo = SMSConversation.copy(convo);
            newConvo.message = message;
            fullConversations.add(newConvo);
          }

          print("calling callback " + fullConversations.toString());
          callback(
            fullConversations,
            crmContacts.values.toList(),
            contacts.values.toList());
        });
  }

  getMessages(SMSConversation convo, int groupId, int limit, int offset,
      Function(List<SMSMessage> messages) callback) {
    fusionConnection.apiV1Call("get", "/chat/conversation/messages", {
      'my_numbers': convo.myNumber,
      'their_numbers': convo.number,
      'limit': limit,
      'offset': offset,
      'group_id': groupId
    }, callback: (Map<String, dynamic> data) {
      List<SMSMessage> messages = [];
      print(data);
      for (Map<String, dynamic> item in data['items']) {
        SMSMessage message = SMSMessage(item);
        storeRecord(message);
        messages.add(message);
      }
      callback(messages);
    });
  }
}
