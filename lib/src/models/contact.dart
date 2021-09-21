import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'dart:convert' as convert;

import 'carbon_date.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class Contact extends FusionModel {
  List<dynamic> addresses;
  String company;
  List<dynamic> contacts;
  CarbonDate createdAt;
  bool deleted;
  String domain;
  List<dynamic> emails;
  String firstContactDate;
  Coworker coworker;
  String firstName;
  List<String> groups;
  String id;
  String jobTitle;
  String lastName;
  String leadCreationDate;
  String name;
  String owner;
  String parentId;
  List<dynamic> phoneNumbers;
  List<dynamic> pictures;
  List<dynamic> socials;
  Map<String, dynamic> lastCommunication;
  String type;
  String uid;
  CarbonDate updatedAt;
  String crmUrl;
  String crmName;
  String crmId;
  int unread = 0;

  @override
  String getId() => this.id;

  searchString() {
    List<String> list = [company, firstName, lastName];
    for (Map<String, dynamic> number in phoneNumbers) {
      list.add(number['number'].toString());
    }
    for (Map<String, dynamic> email in emails) {
      list.add(email['email'].toString());
    }
    return list.join(' ');
  }

  Contact(Map<String, dynamic> contactObject) {
    this.addresses = contactObject['addresses'];
    this.company = contactObject['company'];
    this.contacts = contactObject['contacts'];
    this.createdAt = CarbonDate(contactObject['created_at']);
    this.deleted = contactObject['deleted'];
    this.domain = contactObject['domain'];
    this.emails = contactObject['emails'];
    this.firstContactDate = contactObject['first_contact_date'];
    this.firstName = contactObject['first_name'];
    this.groups = contactObject['groups'].cast<String>();
    this.id = contactObject['id'];
    this.jobTitle = contactObject['job_title'];
    this.lastName = contactObject['last_name'];
    this.leadCreationDate = contactObject['lead_creation_date'];
    this.name = contactObject['name'];
    this.owner = contactObject['owner'];
    this.parentId = contactObject['parent_id'];
    this.phoneNumbers = contactObject['phone_numbers'];
    this.pictures = contactObject['pictures'];
    this.socials = contactObject['socials'];
    this.type = contactObject['type'];
    if (contactObject['uid'].runtimeType == String) {
      this.uid = contactObject['uid'];
    }
    this.updatedAt = CarbonDate(contactObject['updated_at']);
    this.crmUrl = contactObject['crm_url'];
    this.crmName = contactObject['crm_name'];
    this.crmId = contactObject['crm_id'];
  }

  serialize() {
    return convert.jsonEncode({
    'addresses': this.addresses,
    'company': this.company,
    'contacts': this.contacts,
    'createdAt': this.createdAt.serialize(),
    'deleted': this.deleted,
    'domain': this.domain,
    'emails': this.emails,
    'firstContactDate': this.firstContactDate,
    'coworker': this.coworker,
    'firstName': this.firstName,
    'groups': this.groups,
    'id': this.id,
    'jobTitle': this.jobTitle,
    'lastName': this.lastName,
    'leadCreationDate': this.leadCreationDate,
    'name': this.name,
    'owner': this.owner,
    'parentId': this.parentId,
    'phoneNumbers': this.phoneNumbers,
    'pictures': this.pictures,
    'socials': this.socials,
    'lastCommunication': this.lastCommunication,
    'type': this.type,
    'uid': this.uid,
    'updatedAt': this.updatedAt.serialize(),
    'crmUrl': this.crmUrl,
    'crmName': this.crmName,
    'crmId': this.crmId,
    'unread': this.unread,
  });
  }
  Contact.unserialize(String data) {
    Map<String, dynamic> obj = convert.jsonDecode(data);
    this.addresses = obj['addresses'];
    this.company = obj['company'];
    this.contacts = obj['contacts'];
    this.createdAt = CarbonDate.unserialize(obj['createdAt']);
    this.deleted = obj['deleted'];
    this.domain = obj['domain'];
    this.emails = obj['emails'];
    this.firstContactDate = obj['firstContactDate'];
    this.coworker = obj['coworker'];
    this.firstName = obj['firstName'];
    this.groups = obj['groups'].cast<String>();
    this.id = obj['id'];
    this.jobTitle = obj['jobTitle'];
    this.lastName = obj['lastName'];
    this.leadCreationDate = obj['leadCreationDate'];
    this.name = obj['name'];
    this.owner = obj['owner'];
    this.parentId = obj['parentId'];
    this.phoneNumbers = obj['phoneNumbers'].cast<Map<String, dynamic>>();
    this.pictures = obj['pictures'].cast<Map<String, dynamic>>();
    this.socials = obj['socials'].cast<Map<String, dynamic>>();
    this.lastCommunication = obj['lastCommunication'];
    this.type = obj['type'];
    this.uid = obj['uid'];
    this.updatedAt = CarbonDate.unserialize(obj['updatedAt']);
    this.crmUrl = obj['crmUrl'];
    this.crmName = obj['crmName'];
    this.crmId = obj['crmId'];
    this.unread = obj['unread'];
  }
}

class ContactsStore extends FusionStore<Contact> {
  ContactsStore(FusionConnection fusionConnection) : super(fusionConnection);

  @override
  storeRecord(Contact record) {
    super.storeRecord(record);
    persist(record);
  }

  persist(Contact record) {
    fusionConnection.db.delete('contacts', where: 'id = ?', whereArgs: [record.id]);
    fusionConnection.db.insert(
      'contacts',
      {'id': record.id,
      'company': record.company,
      'deleted': record.deleted ? 1 : 0,
      'searchString': record.searchString(),
      'firstName': record.firstName,
      'lastName': record.lastName,
      'raw': record.serialize()}
    );
    print("persisting -- " + {'id': record.id,
      'company': record.company,
      'deleted': record.deleted ? 1 : 0,
      'searchString': record.searchString(),
      'firstName': record.firstName,
      'lastName': record.lastName,
      'raw': record.serialize()}.toString());
  }

  searchPersisted(
      String query, int limit, int offset, Function(List<Contact>, bool) callback) {
    fusionConnection.db.query(
        'contacts',
        limit: limit,
        offset: offset,
        where: 'searchString Like ?',
        orderBy: "lastName asc, firstName asc",
        whereArgs: ["%" + query + "%"])
        .then((List<Map<String, dynamic>> results) {
      List<Contact> list = [];
      print("persisted contacts match " + query + " " + results.toString());
      for (Map<String, dynamic> result in results) {
        print("persisted contact match " + query + " " + result.toString());
        list.add(Contact.unserialize(result['raw']));
      }
      callback(list, false);
    });
  }

  search(
      String query, int limit, int offset, Function(List<Contact>, bool) callback) {
    query = query.toLowerCase();


    searchPersisted(query, limit, offset, callback);
  /*  List<Contact> matched = getRecords()
        .where((Contact c) {
          return (c.name + " " + c.company).toLowerCase().contains(query);
        })
        .toList()
        .cast<Contact>();

    if (matched.length > 0) {
      var future = new Future.delayed(const Duration(milliseconds: 10), () {

        callback(matched, false);
      });
    }*/

    fusionConnection.apiV1Call("get", "/clients/filtered_contacts", {
      'length': offset + limit,
      'search_query': query,
      'sort_by': 'last_name',
      'group_type_filter': 'any',
      'enterprise': false,
    }, callback: (List<dynamic> datas) {
      List<Contact> response = [];

      datas.forEach((dynamic c) {
        Contact contact = Contact(c as Map<String, dynamic>);
        response.add(contact);
        storeRecord(contact);
      });

      callback(response, true);
    });
  }
}
