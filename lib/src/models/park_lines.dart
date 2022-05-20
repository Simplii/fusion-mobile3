import 'dart:ffi';

import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class ParkLine extends FusionModel {
  int parkLine;
  String phone = "";
  String notes = "";
  String disposition = "";
  DateTime timeParked;
  String parkedBy = "";
  bool isActive;
  List<Contact> contacts;

  ParkLine(Map<String, dynamic> obj) {
    parkLine = obj['parkLine'];
    print(obj['parkLine']);
    if (obj['phone'] != null) this.phone = obj['phone'];
    if (obj['notes'] != null) this.notes = obj['notes'];
    if (obj['disposition'] != null) this.disposition = obj['disposition'];
    if (obj['parkedBy'] != null) this.parkedBy = obj['parkedBy'];
    if (obj['timeParked'] != null)
      this.timeParked = DateTime.parse(obj['timeParked']).toLocal();
    if (obj['isActive'] != null)
      isActive = obj['isActive'];
    else
      isActive = false;
    this.contacts = obj['contacts'] == null
        ? []
        : (obj['contacts'] as List<dynamic>).cast<Map<String, dynamic>>()
            .map((item) {
              return Contact(item);
            })
            .toList()
            .cast<Contact>();
  }

  contactName() {
    for (Contact c in contacts) {
      if (c.fullName() != "Unknown") {
        return c.fullName();
      }
    }
    return "Unknown";
  }

  @override
  String getId() => this.parkLine.toString();
}

class ParkLineStore extends FusionStore<ParkLine> {
  String id_field = "id";

  ParkLineStore(FusionConnection fusionConnection) : super(fusionConnection);

  getParks(Function(List<ParkLine>, bool) callback) {
    fusionConnection
        .apiV2Call("get", "/calls/parkLines", {},
            callback: (Map<String, dynamic> datas) {
      List<ParkLine> response = [];
      print('parklineresponse');
      print(datas);
      for (Map<String, dynamic> item in datas['items']) {
        ParkLine obj = ParkLine(item);
        storeRecord(obj);
        response.add(obj);
      }

      callback(response, true);
    });
  }
}
