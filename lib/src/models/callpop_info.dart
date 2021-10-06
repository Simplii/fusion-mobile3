import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import '../backend/fusion_connection.dart';
import 'contact.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class CallpopInfo extends FusionModel {
  String phoneNumber;
  List<CrmContact> crmContacts;
  List<Contact> contacts;
  List<dynamic> dispositionGroups;
  String _id = 'phoneNumber';

  CallpopInfo(Map<String, dynamic> map) {
    this.phoneNumber = map['phone_number'];
    this.crmContacts = map['crm_contacts'];
    this.contacts = map['contacts'];
    this.dispositionGroups = map['dispositionGroups'];
  }

  String getId() => this.phoneNumber;

  String getCompany({String defaul}) {
    for (Contact c in contacts) {
      if (c.company.trim() != "") {
        return c.company;
      }
    }
    for (CrmContact c in crmContacts) {
      if (c.company.trim() != '') {
        return c.company;
      }
    }
    return defaul != null ? defaul : "";
  }


  String getName({String defaul}) {
    for (Contact c in contacts) {
      if (c.name.trim() != "") {
        return c.name;
      }
    }
    for (CrmContact c in crmContacts) {
      if (c.name.trim() != '') {
        return c.name;
      }
    }
    return defaul != null ? defaul : "";
  }
}

class CallpopInfoStore extends FusionStore<CallpopInfo> {
  Map<String, CallpopInfo> _records = {};
  String _id_field = 'phone_number';

  CallpopInfoStore(FusionConnection _fusionConnection)
      : super(_fusionConnection);

  lookupPhone(String phoneNumber, Function(CallpopInfo callpopInfo) callback) {
    if (hasRecord(phoneNumber)) {
      getRecord(phoneNumber, callback);
    }

    fusionConnection.apiV1Call(
        "get", "/callpop_info", {'phone_number': phoneNumber, 'group_id': -1},
        callback: (Map<String, dynamic> data) {
      List<CrmContact> leads = [];
      List<Contact> contacts = [];

      for (Map<String, dynamic> obj in data['contacts']) {
        contacts.add(Contact(obj));
      }

      for (Map<String, dynamic> obj in data['leads']) {
        leads.add(CrmContact(obj));
      }

      CallpopInfo info = CallpopInfo({
        'phone_number': phoneNumber,
        'crm_contacts': leads,
        'contacts': contacts,
        'dispositions': []
      });

      storeRecord(info);
      callback(info);
    });
  }
}
