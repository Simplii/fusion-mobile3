import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'contact.dart';
import 'coworkers.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class CallHistory extends FusionModel {
  String id;
  DateTime startTime;
  String toDid;
  String fromDid;
  String to;
  String from;
  int duration;
  String recordingUrl;
  Coworker coworker;
  Contact contact;
  CrmContact crmContact;
  bool missed;
  String direction;

  CallHistory(Map<String, dynamic> obj) {
    id = obj['id'].toString();
    startTime = DateTime.fromMillisecondsSinceEpoch(int.parse(obj['starttime']) * 1000);
    toDid = obj['to_did'];
    fromDid = obj['from_did'];
    to = obj['to'];
    from = obj['from'];
    duration = int.parse(obj['duration']);
    if (obj['call_recording'] != null) {
      recordingUrl = obj['call_recording']['url'];
    }
    direction = obj['direction'];
    if (obj['lead'] != null && obj['lead'].runtimeType != bool) {
      crmContact = CrmContact.fromExpanded(obj['lead']);
    }
    if (obj['contact'] != null && obj['contact'].runtimeType != bool) {
      contact = Contact(obj['contact']);
    }
    missed = obj['abandoned'] == "1";
  }

  @override
  String getId() => this.id;
}

class CallHistoryStore extends FusionStore<CallHistory> {
  String id_field = "id";
  CallHistoryStore(FusionConnection fusionConnection) : super(fusionConnection);

  getRecentHistory(int limit, int offset,
                   Function(List<CallHistory>, bool) callback) {
    callback(getRecords(), false);
    fusionConnection.apiV1Call(
        "get",
        "/calls/recent",
        {'limit': limit, 'offset': offset},
        callback: (List<dynamic> datas) {
          List<CallHistory> response = [];

          for (Map<String, dynamic> item in datas) {
            CallHistory obj = CallHistory(item);
            obj.coworker = fusionConnection.coworkers.lookupCoworker(obj.to);
            storeRecord(obj);
            response.add(obj);
          }

          callback(response, true);
        });
  }
}