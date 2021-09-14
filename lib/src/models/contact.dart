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
    this.phoneNumbers = contactObject['phone_number'];
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
  Map<String, Contact> _records = {};

  ContactsStore(FusionConnection fusionConnection) : super(fusionConnection);
}
