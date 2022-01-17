import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'dart:convert' as convert;

import 'carbon_date.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class ContactCrmReference {
  String crmName;
  String module;
  String contactName;
  String url;
  String crmContactId;
  String icon;

  ContactCrmReference(
      {this.crmName,
      this.module,
      this.contactName,
      this.url,
      this.crmContactId,
      this.icon});
}

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
  String firstName = "";
  List<String> groups;
  String id;
  String jobTitle;
  String lastName = "";
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

  List<String> numbersAsStrings() {
    List<String> numbers = [];
    for (Map<String, dynamic> number in phoneNumbers) {
      if (number['number'] != null && number['number'].trim().length > 2) {
        numbers.add(number['number']);
      }
    }
    return numbers;
  }

  String firstNumber() {
    List<String> numbers = numbersAsStrings();
    if (numbers.length > 0)
      return numbers[0];
    else
      return null;
  }

  String fullName() {
    String name = (firstName + " " + lastName).trim();
    return name == "" ? "Unknown" : name;
  }

  List<ContactCrmReference> crms() {
    List<ContactCrmReference> matches = [];

    if (contacts != null) {
      for (Map<String, dynamic> obj in contacts) {
        matches.add(ContactCrmReference(
            url: obj['url'],
            crmContactId: obj['network_id'].toString(),
            contactName: obj['name'],
            crmName: obj['network'],
            module: obj['module'],
            icon: obj['icon']));
      }
    }

    return matches;
  }

  String pictureUrl() {
    if (pictures != null) {
      for (Map<String, dynamic> picture in pictures) {
        if (picture['url'] != null && picture['url'].trim() != '') {
          return picture['url'];
        }
      }
    }
    if (emails != null) {
      for (Map<String, dynamic> email in emails) {
        if (email['email'] != null && email['email'].trim() != '') {}
      }
    }
  }

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
    this.crmId = contactObject['crm_id'].runtimeType == int
        ? contactObject['crm_id'].toString()
        : contactObject['crm_id'];
  }

  Map<String, dynamic> serverPayload() {
    return {
      "addresses": addresses,
      "company": company,
      "contacts": contacts,
      "emails": emails,
      "first_name": firstName,
      "groups": groups,
      "id": id,
      "job_title": jobTitle,
      "last_name": lastName,
      "name": name,
      "owner": owner,
      "phone_numbers": phoneNumbers,
      "pictures": pictures,
      "socials": socials,
      "type": type,
      "uid": uid
    };
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

  Contact.copy(Contact contact) {
    this.addresses = convert.jsonDecode(convert.jsonEncode(contact.socials));
    this.company = contact.company;
    this.contacts = contact.contacts;
    this.createdAt = contact.createdAt;
    this.deleted = contact.deleted;
    this.domain = contact.domain;
    this.emails = convert.jsonDecode(convert.jsonEncode(contact.emails));
    this.firstContactDate = contact.firstContactDate;
    this.coworker = contact.coworker;
    this.firstName = contact.firstName;
    this.groups = contact.groups;
    this.id = contact.id;
    this.jobTitle = contact.jobTitle;
    this.lastName = contact.lastName;
    this.leadCreationDate = contact.leadCreationDate;
    this.name = contact.name;
    this.owner = contact.owner;
    this.parentId = contact.parentId;
    this.phoneNumbers =
        convert.jsonDecode(convert.jsonEncode(contact.phoneNumbers));
    this.pictures = convert.jsonDecode(convert.jsonEncode(contact.pictures));
    this.socials = convert.jsonDecode(convert.jsonEncode(contact.socials));
    this.lastCommunication = contact.lastCommunication;
    this.type = contact.type;
    this.uid = contact.uid;
    this.updatedAt = contact.updatedAt;
    this.crmUrl = contact.crmUrl;
    this.crmName = contact.crmName;
    this.crmId = contact.crmId;
    this.unread = contact.unread;
  }

  copy(Contact contact) {
    this.addresses = convert.jsonDecode(convert.jsonEncode(contact.socials));
    this.company = contact.company;
    this.contacts = contact.contacts;
    this.createdAt = contact.createdAt;
    this.deleted = contact.deleted;
    this.domain = contact.domain;
    this.emails = convert.jsonDecode(convert.jsonEncode(contact.emails));
    this.firstContactDate = contact.firstContactDate;
    this.coworker = contact.coworker;
    this.firstName = contact.firstName;
    this.groups = contact.groups;
    this.id = contact.id;
    this.jobTitle = contact.jobTitle;
    this.lastName = contact.lastName;
    this.leadCreationDate = contact.leadCreationDate;
    this.name = contact.name;
    this.owner = contact.owner;
    this.parentId = contact.parentId;
    this.phoneNumbers =
        convert.jsonDecode(convert.jsonEncode(contact.phoneNumbers));
    this.pictures = convert.jsonDecode(convert.jsonEncode(contact.pictures));
    this.socials = convert.jsonDecode(convert.jsonEncode(contact.socials));
    this.lastCommunication = contact.lastCommunication;
    this.type = contact.type;
    this.uid = contact.uid;
    this.updatedAt = contact.updatedAt;
    this.crmUrl = contact.crmUrl;
    this.crmName = contact.crmName;
    this.crmId = contact.crmId;
    this.unread = contact.unread;
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
    fusionConnection.db
        .delete('contacts', where: 'id = ?', whereArgs: [record.id]);
    fusionConnection.db.insert('contacts', {
      'id': record.id,
      'company': record.company,
      'deleted': record.deleted ? 1 : 0,
      'searchString': record.searchString(),
      'firstName': record.firstName,
      'lastName': record.lastName,
      'raw': record.serialize()
    });
  }

  searchPersisted(String query, int limit, int offset,
      Function(List<Contact>, bool) callback) {
    fusionConnection.db.query('contacts',
        limit: limit,
        offset: offset,
        where: 'searchString Like ?',
        orderBy: "lastName asc, firstName asc",
        whereArgs: [
          "%" + query + "%"
        ]).then((List<Map<String, dynamic>> results) {
      List<Contact> list = [];

      for (Map<String, dynamic> result in results) {
        list.add(Contact.unserialize(result['raw']));
      }
      callback(list, false);
    });
  }

  search(String query, int limit, int offset,
      Function(List<Contact>, bool) callback) {
    query = query.toLowerCase();

    searchPersisted(query, limit, offset, callback);

    fusionConnection.apiV1Call("get", "/clients/filtered_contacts", {
      'length': offset + limit,
      'search_query': query,
      'sort_by': 'last_name',
      'group_type_filter': 'any',
      'enterprise': false,
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

  void save(Contact edited) {
    storeRecord(edited);
    fusionConnection.apiV1Call("post", "/clients/filtered_contacts",
        {'contact': edited.serverPayload()},
        callback: (List<dynamic> datas) {});
  }
}
