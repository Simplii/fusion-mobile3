import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'fusion_model.dart';
import 'messages.dart';
import 'crm_contact.dart';
import 'contact.dart';
import '../backend/fusion_connection.dart';
import 'fusion_store.dart';

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
    print("contact name" + this.contacts.toString() + ":" + this.crmContacts.toString());
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

  SMSConversation(Map<String, dynamic> map) {
    this.groupName = map['group_name'];
    this.isGroup = map['is_group'];
    this.lastContactTime = map['last_contact_time'];
    this.myNumber = map['my_number'];
    this.number = map['number'];
    this.members = [];//map['members'];
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

  SMSConversationsStore(FusionConnection _fusionConnection) : super(_fusionConnection);

  getConversations(int groupId, Function(List<SMSConversation> conversations) callback) {
    List<String> numbers = ["8014569811","8014569812","2088000011"];

    fusionConnection.apiV1Call(
        "get",
        "/chat/conversations_with/with_message",
        {'numbers': numbers.join(","),
          'limit': 100,
          'group_id': groupId},
        callback: (Map<String, dynamic> data) {
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
