import 'dart:convert';

import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import 'carbon_date.dart';
import 'dids.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class SMSDepartment extends FusionModel {
  String groupName;
  String id;
  List<String> numbers = [];
  List<String> mmsNumbers = [];
  String primaryUser;
  int unreadCount;
  bool usesDynamicOutbound;

  SMSDepartment(Map<String, dynamic> obj) {
    if (obj['id'].toString() == "-1") {
      id = "-1";
      groupName = "Personal";
      for (String n in obj['numbers']) { numbers.add(n); }
      unreadCount = obj['unread'];
      usesDynamicOutbound = false;
      primaryUser = null;
      if (obj.containsKey('mms_numbers')) {
        for (String n in obj['mms_numbers']) { mmsNumbers.add(n); }
      }
    }
    else {
      id = obj['id'].toString();
      groupName = obj['group_name'];
      for (String n in obj['numbers']) { numbers.add(n); }
      for (String n in obj['mms_numbers']) { mmsNumbers.add(n); }
      primaryUser = obj['primary_user'];
      unreadCount = obj['unread'];
      usesDynamicOutbound = obj['uses_dynamic_outbound'];
    }
  }

  serserialize() {
    return jsonEncode({
      'groupName': this.groupName,
      'id': this.id,
      'numbers': this.numbers,
      'mmsNumbers': mmsNumbers,
      'primaryUser': this.primaryUser,
      'unreadCount': this.unreadCount,
      'usesDynamicOutbound': this.usesDynamicOutbound,
    });
  }

  Did toDid(){
      return Did({
        "to_user" : "",
        "did":  this.id,
        // "mmsCapable": false,
        "plan_description": "Dynamic Dialing",
        "groupName" : this.groupName,
        "favorite" : false
      });
  }
  String getId() => this.id;
}

class SMSDepartmentsStore extends FusionStore<SMSDepartment> {
  String id_field = "id";
  SMSDepartmentsStore(FusionConnection fusionConnection) : super(fusionConnection);

  getDepartments(Function(List<SMSDepartment>) callback) {
    fusionConnection.apiV1Call(
        "get",
        "/chat/my_groups",
        {},
        callback: (List<dynamic> datas) {
          List<String> allNumbers = [];
          List<String> allMMSNumbers = [];
          int allUnread = 0;

          for (Map<String, dynamic> data in datas) {
            allUnread += data['unread'];
            for (String n in data['mms_numbers']) { allMMSNumbers.add(n); }
            for (String n in data['numbers']) { allNumbers.add(n); }
            storeRecord(SMSDepartment(data));
          }

          storeRecord(SMSDepartment({
                                      'id': '-2',
                                      'group_name': 'All Messages',
                                      'numbers': allNumbers,
                                      'mms_numbers': allMMSNumbers,
                                      'unread': allUnread,
                                      'uses_dynamic_outbound': false,
                                      'primary_user': null
                                    }));

          callback(allDepartments());
        });
  }

  getDepartment(String id) {
    return lookupRecord(id);
  }

  allDepartments() {
    return getRecords();
  }

  SMSDepartment getDepartmentByPhoneNumber(number) {
    List<SMSDepartment> departments = allDepartments();
    for (SMSDepartment dept in departments) {
      if (dept.numbers.contains(number))
        return dept;
    }
    return null;
  }
}
