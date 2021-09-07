
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import 'carbon_date.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class Contact extends FusionModel {
  List<dynamic> addresses;
  String company;
  List<dynamic> contacts;
  CarbonDate created_at;
  bool deleted;
  String domain;
  List<dynamic> emails;
  String first_contact_date;
  String first_name;
  List<String> groups;
  String id;
  String job_title;
  String last_name;
  String lead_creation_date;
  String name;
  String owner;
  String parent_id;
  List<dynamic> phone_number;
  List<dynamic> pictures;
  List<dynamic> socials;
  String type;
  String uid;
  CarbonDate updated_at;
  String crm_url;
  String crm_name;
  String crm_id;

  String getId() => this.id;

  Contact(Map<String, dynamic> contactObject) {
    this.addresses = contactObject['addresses'];
    this.company = contactObject['company'];
    this.contacts = contactObject['contacts'];
    this.created_at = CarbonDate(contactObject['created_at']);
    this.deleted = contactObject['deleted'];
    this.domain = contactObject['domain'];
    this.emails = contactObject['emails'];
    this.first_contact_date = contactObject['first_contact_date'];
    this.first_name = contactObject['first_name'];
    this.groups = contactObject['groups'].cast<String>();
    this.id = contactObject['id'];
    this.job_title = contactObject['job_title'];
    this.last_name = contactObject['last_name'];
    this.lead_creation_date = contactObject['lead_creation_date'];
    this.name = contactObject['name'];
    this.owner = contactObject['owner'];
    this.parent_id = contactObject['parent_id'];
    this.phone_number = contactObject['phone_number'];
    this.pictures = contactObject['pictures'];
    this.socials = contactObject['socials'];
    this.type = contactObject['type'];
    if (contactObject['uid'].runtimeType == String) {
      this.uid = contactObject['uid']; }
    this.updated_at = CarbonDate(contactObject['updated_at']);
    this.crm_url = contactObject['crm_url'];
    this.crm_name = contactObject['crm_name'];
    this.crm_id = contactObject['crm_id'];
  }
}

class ContactsStore extends FusionStore<Contact>{
  Map<String, Contact> _records = {};

  ContactsStore(FusionConnection fusionConnection) : super(fusionConnection);
}

