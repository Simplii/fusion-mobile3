import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/models/unreads.dart';
import 'package:fusion_mobile_revamped/src/utils.dart';
import 'dart:convert' as convert;

import '../backend/fusion_connection.dart';
import 'contact.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';
import 'messages.dart';
import 'sms_departments.dart';

class SMSConversation extends FusionModel {
  List<CrmContact> crmContacts = [];
  List<Contact> contacts = [];
  String groupName;
  String hash;
  bool isGroup;
  String lastContactTime;
  List<dynamic> members;
  SMSMessage message;
  String number;
  String myNumber;
  int unread;
  int conversationId;
  String selectedDepartmentId;

  String contactName() {
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
    if(this.isGroup){
      name = this.hash.replaceAll(':', ',').formatPhone();  
    }
    return name;
  }

  SMSConversation.build(
      {this.myNumber,
      this.number,
      this.message,
      this.contacts,
      this.crmContacts,
      this.conversationId,
      this.isGroup,
      this.hash,
      this.selectedDepartmentId = "-1"}) {
    this.hash = this.hash ?? this.myNumber + ":" + this.number;
    this.unread = 0;
    if (this.message != null) {
      this.lastContactTime = message.time.date;
    }
  }

  SMSConversation.copy(SMSConversation c) {
    conversationId = c.conversationId;
    this.groupName = c.groupName;
    this.isGroup = c.isGroup;
    this.lastContactTime = c.lastContactTime;
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
    String toNumber = map['lastMessage']['from'] == map['myNumber'] 
      ? map['lastMessage']['to']
      : map['lastMessage']['from'];
    this.conversationId = map['conversationId'] ?? map['groupId'];
    this.groupName = map['groupName'];
    this.isGroup = map['isGroup'];
    this.lastContactTime = map['lastContactTime'];
    this.myNumber = map['myNumber'];
    this.number = map['isGroup'] != null && map['isGroup'] == true ? map['groupId'].toString() : toNumber;
    this.members = map['conversationMembers']; //map['members'];
    this.message = map['message'];
    this.unread = map['unreadCount'];
    this.crmContacts = map['crm_contacts'] ?? [];
    this.contacts = map['contacts'];
    this.hash = map['hash'];
  }

  serialize() {
    return convert.jsonEncode({
      'conversationId': this.conversationId,
      'hash': this.hash,
      'groupName': this.groupName,
      'isGroup': this.isGroup,
      'lastContactTime': this.lastContactTime,
      'myNumber': myNumber,
      'number': number,
      'members': members,
      'message': message?.serialize(),
      'unread': unread,
      'crmContacts': crmContacts.map((CrmContact c) {
            return c.serialize();
          })
          .toList()
          .cast<String>(),
      'contacts': contacts
          .map((Contact c) {
            return c.serialize();
          })
          .toList()
          .cast<String>(),
    });
  }

  SMSConversation.unserialize(String dataString) {
    
    Map<String, dynamic> data = convert.jsonDecode(dataString);
    this.conversationId = data['groupId'] != null ? data['groupId'] : data['conversationId'];
    this.groupName = data['groupName'];
    this.isGroup = (data['isGroup'] == 1 || data['isGroup'] == true) ? true : false;
    this.lastContactTime = data['lastContactTime'];
    this.lastContactTime = data['lastContactTime'];
    this.myNumber = data['myNumber'];
    this.number = data['to'] != null ? data['to'] : data['number'];
    this.members = data['conversationMembers'];
    this.message = SMSMessage.unserialize(data['message']);
    this.unread = data['unread'];
    this.crmContacts = data['crmContacts']
        .cast<String>()
        .map((String s) {
          return CrmContact.unserialize(s);
        })
        .toList()
        .cast<CrmContact>();
    this.contacts = data['contacts']
        .cast<String>()
        .map((String s) {
          return Contact.unserialize(s);
        })
        .toList()
        .cast<Contact>();
    this.hash = data['hash'];
  }

  String searchString() {
    return [number, myNumber, message.message].join(' ');
  }

  @override
  String getId() => this.hash;
}

class SMSConversationsStore extends FusionStore<SMSConversation> {
  String _id_field = 'hash';

  SMSConversationsStore(FusionConnection _fusionConnection)
      : super(_fusionConnection);

  @override
  storeRecord(SMSConversation record) {
    super.storeRecord(record);
    persist(record);
  }

  @override
  removeRecord(String id) {
    super.removeRecord(id);
    fusionConnection.db.delete('sms_conversation',
        where: 'id = ?',
        whereArgs: [id]);
  }

  persist(SMSConversation record) {
    fusionConnection.db.delete('sms_conversation',
        where: 'id = ?', whereArgs: [record.getId()]);
    fusionConnection.db.insert('sms_conversation', {
      'id': record.getId(),
      'groupName': record.groupName,
      'isGroup': record.isGroup ? 1 : 0,
      'lastContactTime': DateTime.parse(record.lastContactTime)
              .toLocal()
              .millisecondsSinceEpoch /
          1000,
      'searchString': record.searchString(),
      'number': record.isGroup ? record.conversationId : record.number,
      'myNumber': record.myNumber,
      'unread': record.unread,
      'raw': record.serialize(),
      'conversationId': record.conversationId
    });
  }

  getPersisted(String groupId, int limit, int offset,
      Function(List<SMSConversation> conversations, bool fromServer) callback) {
    SMSDepartment group = fusionConnection.smsDepartments.lookupRecord(groupId);
    if (group != null) {

      fusionConnection.db.query(
          'sms_conversation',
          limit: limit,
          offset: offset,
          orderBy: 'lastContactTime DESC',
          where: 'myNumber in ("' + group.numbers.join('","') + '")')
          .then((List<Map<String, dynamic>> results) {
        List<SMSConversation> list = [];
        for (Map<String, dynamic> result in results) {
          list.add(SMSConversation.unserialize(result['raw']));
        }
        callback(list, false);
      });
    }
  }

  searchPersisted(String query, String groupId, int limit, int offset,
      Function(List<SMSConversation> conversations, bool fromServer) callback) {
    SMSDepartment group = fusionConnection.smsDepartments.lookupRecord(groupId);
    if (group != null) {
      fusionConnection.db.query('sms_conversation',
          limit: limit,
          offset: offset,
          where: 'myNumber in ("' +
              group.numbers.join('","') +
              '") AND searchString Like ?',
          whereArgs: [
            "%" + query + "%"
          ]).then((List<Map<String, dynamic>> results) {
        List<SMSConversation> list = [];
        for (Map<String, dynamic> result in results) {
          list.add(SMSConversation.unserialize(result['raw']));
        }
        callback(list, false);
      });
    }
  }

  getConversations(String groupId, int limit, int offset,
      Function(List<SMSConversation> conversations, bool fromServer) callback) {
    // SMSDepartment department =
    //     fusionConnection.smsDepartments.getDepartment(groupId);
    // List<String> numbers = department.numbers;

    getPersisted(groupId, limit, offset, callback);
    fusionConnection.refreshUnreads();

    fusionConnection.apiV2Call("get", "/messaging/group/${groupId}/conversations", {
      // 'numbers': numbers.join(","),
      'limit': limit,
      'offset': offset,
      // 'group_id': groupId
    }, callback: (Map<String, dynamic> data) {
      List<SMSConversation> convos = [];
      for (Map<String, dynamic> item in data['items']) {
        List<CrmContact> leads = [];
        List<Contact> contacts = [];
        

        if(item['conversationMembers'] != null){
          for (Map<String, dynamic> obj in item['conversationMembers']) {
            List<dynamic> convoMembebersContacts = obj['contacts'];
            List<dynamic> convoMembebersLeads = obj['leads'] ?? [];
            dynamic number = obj['number'];
            if(convoMembebersContacts.length > 0){
              convoMembebersContacts.forEach((contact) { 
                contacts.add(Contact.fromV2(contact));
              });
            } 
            else if(convoMembebersLeads.length > 0){
              convoMembebersLeads.forEach((lead) { 
                contacts.add(CrmContact.fromExpanded(lead).toContact());
              });
            }
            else if(convoMembebersContacts.length == 0 && convoMembebersLeads.length == 0 && number != ''){
              contacts.add(Contact.fake(number));
            }
          }
        }

        // if (item.containsKey('contacts') && item['contacts'] != null) {
        //   for (Map<String, dynamic> obj in item['contacts']) {
        //     contacts.add(Contact(obj));
        //   }
        // }

        // if (item.containsKey('leads') && item['leads'] != null) {
        //   for (Map<String, dynamic> obj in item['leads']) {
        //     leads.add(CrmContact(obj));
        //   }
        // }

        item['contacts'] = contacts;
        item['crm_contacts'] = leads;
        if(item['lastMessage'] != null ){
          item['message'] = SMSMessage.fromV2(item['lastMessage']);
        } 
        if(item['message']== null)break;
        SMSConversation convo =  SMSConversation(item);
        storeRecord(convo);
        convos.add(convo);
      }
      callback(convos, true);
    });
  }

  void markRead(SMSConversation convo) {
    var future = new Future.delayed(const Duration(milliseconds: 2000), () {
      fusionConnection.refreshUnreads();
    });
    convo.unread = 0;
    storeRecord(convo);
  }

  void clearPersistedConvoMessages(SMSConversation convo){
    fusionConnection.db.delete('sms_message',
         where: '(`to` = ? and `from` = ?) or (`from` = ? and `to` = ?)',
        whereArgs: [
          convo.myNumber,
          convo.number,
          convo.myNumber,
          convo.number]);

  }
  void deleteConversation(SMSConversation convo, String departmentId) {
    this.removeRecord(convo.getId());
    clearPersistedConvoMessages(convo);

    fusionConnection
      .apiV2Call("post", "/messaging/group/${departmentId}/conversations/${convo.conversationId}/archive", {
    }, callback: null);
  }

  void markUnread (String messageId, SMSConversation conversation, Function closeConvo){
    conversation.unread = 1;
    storeRecord(conversation);
    fusionConnection.apiV2Call("get", "/messaging/message/$messageId/markUnread",
      {},
      callback: closeConvo()
    );
  }
}
