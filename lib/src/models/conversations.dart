import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import '../backend/fusion_connection.dart';
import 'contact.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';
import 'messages.dart';
import 'sms_departments.dart';

class SMSConversation extends FusionModel {
  List<CrmContact> crmContacts;
  List<Contact> contacts;
  String groupName;
  String hash;
  bool isGroup;
  String lastContactTime;
  List<String> members;
  SMSMessage message;
  String number;
  String myNumber;
  int unread;

  String contactName() {
    print("contact name" +
        this.contacts.toString() +
        ":" +
        this.crmContacts.toString());
    String name = "Unknown";
    if (contacts != null) {
      for (Contact contact in contacts) {
        if (contact.name != null && contact.name.trim() != "") {
          name = contact.name;
        }
      }
    }
    if (crmContacts != null) {
      for (CrmContact contact in crmContacts) {
        if (contact.name != null && contact.name.trim() != "") {
          name = contact.name;
        }
      }
    }
    return name;
  }

  SMSConversation.build(
      {this.myNumber,
      this.number,
      this.message,
      this.contacts,
      this.crmContacts}) {
    this.hash = this.myNumber + ":" + this.number;
    this.unread = 0;
    if (this.message != null) {
      this.lastContactTime = message.time.date;
    }
  }

  SMSConversation.copy(SMSConversation c) {
    this.groupName = c.groupName;
    this.isGroup = c.isGroup;
    this.lastContactTime = c.lastContactTime;
    this.myNumber = c.myNumber;
    this.number = c.number;
    this.members = c.members;
    this.message = c.message;
    this.unread = c.unread;
    this.crmContacts = c.crmContacts;
    this.contacts = c.contacts;
    this.hash = c.hash;
  }

  SMSConversation(Map<String, dynamic> map) {
    this.groupName = map['group_name'];
    this.isGroup = map['is_group'];
    this.lastContactTime = map['last_contact_time'];
    this.myNumber = map['my_number'];
    this.number = map['number'];
    this.members = []; //map['members'];
    this.message = map['message'];
    this.unread = int.parse(map['unread'].toString());
    this.crmContacts = map['crm_contacts'];
    this.contacts = map['contacts'];
    this.hash = map['my_number'] + ':' + map['number'];
  }

  String getId() => this.hash;
}

class SMSConversationsStore extends FusionStore<SMSConversation> {
  String _id_field = 'hash';

  SMSConversationsStore(FusionConnection _fusionConnection)
      : super(_fusionConnection);

  getConversations(
      String groupId, Function(List<SMSConversation> conversations) callback) {
    SMSDepartment department = fusionConnection.smsDepartments.getDepartment(groupId);
    List<String> numbers = department.numbers;



    fusionConnection.apiV1Call("get", "/chat/conversations_with/with_message", {
      'numbers': numbers.join(","),
      'limit': 100,
      'group_id': groupId
    }, callback: (Map<String, dynamic> data) {
      List<SMSConversation> convos = [];
      print(data);
      for (Map<String, dynamic> item in data['items']) {
        List<CrmContact> leads = [];
        List<Contact> contacts = [];
        print('parsing data' + item.toString());
        if (item.containsKey('contacts') && item['contacts'] != null) {
          for (Map<String, dynamic> obj in item['contacts']) {
            contacts.add(Contact(obj));
          }
        }

        if (item.containsKey('leads') && item['leads'] != null) {
          for (Map<String, dynamic> obj in item['leads']) {
            leads.add(CrmContact(obj));
          }
        }

        item['contacts'] = contacts;
        item['crm_contacts'] = leads;
        item['message'] = SMSMessage(item['message']);

        SMSConversation convo = SMSConversation(item);
        storeRecord(convo);
        convos.add(convo);
      }
      callback(convos);
    });
  }
}
