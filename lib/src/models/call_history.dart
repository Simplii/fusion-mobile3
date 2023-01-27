import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'contact.dart';
import 'coworkers.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';
import '../utils.dart';

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
  String callerId;

  isInternal(String domain) {
     //getting X1012wp in inbound breaks the recent call list
    print("MyDebugMessage ${to}");
    if (direction == 'inbound')
      return to.substring(to.length - domain.length)
          .toLowerCase() == domain.toLowerCase();
    else
      return from.substring(from.length - domain.length)
          .toLowerCase() == domain.toLowerCase();
  }

  getOtherNumber(String domain) {
    return isInternal(domain) && to != "abandoned"
        ? (direction == "inbound" ? from : to).toString()
        : (direction == "inbound" ? fromDid : toDid).toString();
  }

  CallHistory(Map<String, dynamic> obj) {
    id = obj['id'].toString();
    startTime = DateTime.parse(obj['startTime']).toLocal();
    toDid = obj['toDid'];
    fromDid = obj['fromDid'];
    to = obj['to'];
    from = obj['from'];
    duration = obj['duration'];
    recordingUrl = obj['recordingUrl'];
    direction = obj['direction'];
    callerId = obj['callerId'];
    if (direction == 'Incoming') {
      direction = 'inbound';
    } else if (direction == 'Outgoing') {
      direction = 'outbound';
    }

    if (obj['lead'] != null && obj['lead'].runtimeType != bool) {
      crmContact = CrmContact.fromExpanded(obj['lead']);
    }
    if (obj['contact'] != null && obj['contact'].runtimeType != bool) {
      contact = Contact(obj['contact']);
    }

    if (obj['contacts'] != null) {
      List list = obj['contacts'];
      if (list.length > 0) {
        contact = Contact.fromV2(list[0]);
      }
    }
    missed = obj['to'] == "abandoned";
  }

  isInbound() {
    return direction == "inbound";
  }

  @override
  String getId() => this.id;
}

class CallHistoryStore extends FusionStore<CallHistory> {
  String id_field = "id";
  CallHistoryStore(FusionConnection fusionConnection) : super(fusionConnection);

  getRecentHistory(int limit, int offset,
      Function(List<CallHistory>, bool) callback) {
    List<CallHistory> stored = getRecords();
    stored.sort((a, b) {
      return a.startTime.isBefore(b.startTime) ? 1 : -1;
    });
    List<String> usedIds = [];
    List<CallHistory> filtered = [];

    stored.forEach((element) {
      if (!usedIds.contains(element.id)) {
        usedIds.add(element.id);
        filtered.add(element);
      }
    });

    callback(filtered, false);
    fusionConnection.apiV2Call(
        "get",
        "/calls/recent",
        {'limit': limit, 'offset': offset},
        callback: (Map<String, dynamic> datas) {
          List<CallHistory> response = [];
          for (Map<String, dynamic> item in datas['items']) {
            CallHistory obj = CallHistory(item);
            obj.coworker = fusionConnection.coworkers.lookupCoworker(
                obj.direction == 'inbound' ? obj.from : obj.to);

            storeRecord(obj);
            response.add(obj);
          }

          response.sort((a, b) {
            return a.startTime.isBefore(b.startTime) ? 1 : -1;
          });

          callback(response, true);
        });
  }
}