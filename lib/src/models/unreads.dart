import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

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
      print("urneads");print(datas);
          List<DepartmentUnreadRecord> response = [];
          clearRecords();
          for (Map<String, dynamic> item in datas.cast<Map<String, dynamic>>()) {
            DepartmentUnreadRecord obj = DepartmentUnreadRecord(item);
            storeRecord(obj);
            response.add(obj);
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
