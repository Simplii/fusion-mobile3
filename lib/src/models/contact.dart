import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

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
  String type;
  String uid;
  CarbonDate updatedAt;
  String crmUrl;
  String crmName;
  String crmId;

  String getId() => this.id;

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
}

class ContactsStore extends FusionStore<Contact> {
  ContactsStore(FusionConnection fusionConnection) : super(fusionConnection);

  search(String query, int limit, int offset, Function(List<Contact>) callback) {
        fusionConnection.apiV1Call(
        "get",
        "/clients/filtered_contacts",
        {'length': offset + limit,
        'search_query': query,
        'sort_by': 'last_name',
        'group_type_filter': 'any',
        'enterprise': false,
        },
        callback: (List<dynamic> datas) {
          print("gotinfo" + datas.toString());
          List<Contact> response = [];

          datas.forEach((dynamic c) {
            response.add(Contact(c as Map<String, dynamic>));
          });

          callback(response);
        });
  }
}
