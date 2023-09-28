import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';

import 'fusion_model.dart';
import 'fusion_store.dart';

class DepartmentUnreadRecord extends FusionModel {
  int departmentId;
  int unread;
  String inq;
  String to;
  List<String> numbers;

  DepartmentUnreadRecord(Map<String, dynamic> obj) {
    this.departmentId = obj['id'];
    this.unread = obj['unread'];
    this.inq = obj['inq'];
  }
}

class UnreadsStore extends FusionStore<DepartmentUnreadRecord> {
  String id_field = "id";
  UnreadsStore(FusionConnection fusionConnection) : super(fusionConnection);

  getUnreads(Function(List<DepartmentUnreadRecord>, bool) callback) {
    fusionConnection.apiV2Call("get", "/messaging/unread", {},
        callback: (List<dynamic> datas) {
          List<DepartmentUnreadRecord> response = [];
          clearRecords();
          List<SMSDepartment> deps = fusionConnection.smsDepartments.allDepartments();
          if(datas.isEmpty){
            for (SMSDepartment dep in deps) {
                  dep.unreadCount = 0;
                  fusionConnection.smsDepartments.storeRecord(dep);
              }
          }
          for (Map<String, dynamic> item in datas.cast<Map<String, dynamic>>()) {
            DepartmentUnreadRecord obj = DepartmentUnreadRecord(item);
            storeRecord(obj);
            response.add(obj);
            if(item.containsKey('departmentId')){
              List nums = item['numbers'];
              for (SMSDepartment dep in deps) {
                if(nums.isNotEmpty && nums[0].toString().contains('@') && item['departmentId'] == -1){
                  item['departmentId'] = -3;
                }
                if(dep.id == item['departmentId'].toString()){
                  dep.unreadCount = item['unread'];
                  fusionConnection.smsDepartments.storeRecord(dep);
                }
              }
            }
          }
            callback(response, true);

        });
  }

  hasUnread() {
    List<DepartmentUnreadRecord> records = this.getRecords();
    int count = 0;
    for (DepartmentUnreadRecord record in records) {
      count += record.unread;
    }
    return count > 0;
  }
}
