import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'contact.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class Coworker extends FusionModel {
  String email = "";
  String extension = "";
  String uid = "";
  String firstName = "";
  String lastName = "";
  String statusMessage = "";
  String group = "";
  String presence = "";
  String url = "";

  Coworker(Map<String, dynamic> obj) {
    if (obj['email'].runtimeType == String) email = obj['email'];
    if (obj['first_name'].runtimeType == String) firstName = obj['first_name'];
    if (obj['last_name'].runtimeType == String) lastName = obj['last_name'];
    if (obj['message'].runtimeType == String) statusMessage = obj['message'];
    if (obj['group'].runtimeType == String) group = obj['group'];
    if (obj['presence'].runtimeType == String) presence = obj['presence'];
    extension = obj['user'];
    uid = obj['uid'].toLowerCase();
  }

  getDomain() {
    return uid.split('@')[1];
  }

  toContact() {
    Contact c = Contact({
      'addresses': [],
      'company': getDomain(),
      'contacts': [],
      'deleted': false,
      'domain': getDomain(),
      'emails': email != '' ? [{'email': email, 'type': 'Work'}] : [],
      'first_contact_diate': '',
      'first_name': firstName,
      'last_name': lastName,
      'groups': [group],
      'id': uid,
      'job_title': '',
      'lead_creation_date': '',
      'name': firstName + ' ' + lastName,
      'owner': '',
      'parent_id': '',
      'phone_numbers': [{'number': uid, 'type': 'Extension'}],
      'pictures': [],
      'socials': [],
      'type': '',
      'updated_at': {'date': '', 'timezone': '', 'timezone_type': 1},
      'created_at': {'date': '', 'timezone': '', 'timezone_type': 1},
      'crm_url': '',
      'crm_name': 'Fusion',
      'crm_id': uid}
    );
    c.coworker = this;
    return c;
  }

  String getId() => this.uid.toLowerCase();
}

class CoworkerStore extends FusionStore<Coworker> {
  String id_field = "uid";
  CoworkerStore(FusionConnection fusionConnection) : super(fusionConnection);

  Coworker lookupCoworker(String uid) {
    return lookupRecord(uid.toLowerCase());
  }

  String avatarFor(Coworker c) {
    String url = fusionConnection.settings.avatarForUser(c.uid);
    if (url == fusionConnection.defaultAvatar && c.email != "") {
      try {
        return Gravatar(c.email).imageUrl(defaultImage: fusionConnection.defaultAvatar); }
      catch (e) {
        return url;
      }
    } else {
      return url;
    }
  }

  search(String query, Function(List<Contact>) callback) {
    List<Contact> list = [];
    for (Coworker c in getRecords()) {
      if ((c.firstName + " " + c.lastName
          + " " + c.email + " " + c.uid).contains(query)) {
        list.add(c.toContact());
      }
    }
    callback(list);
  }

  getCoworkers(Function(List<Coworker>) callback) {
    callback(getRecords());
    fusionConnection.apiV1Call(
        "get",
        "/clients/subscribers",
        {},
        callback: (List<dynamic> datas) {
          List<Coworker> response = [];

          for (Map<String, dynamic> item in datas) {
            Coworker obj = Coworker(item);
            obj.url = avatarFor(obj);
            storeRecord(obj);
            response.add(obj);
          }

          callback(response);
        });
  }
}