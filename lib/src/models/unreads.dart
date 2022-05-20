import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import 'fusion_model.dart';
import 'fusion_store.dart';

class UnreadMessage extends FusionModel {
  String id;
  int unread;
  String inq;
  String to;
  List<String> numbers;

  UnreadMessage(Map<String, dynamic> obj) {
    this.id = obj['id'];
    this.unread = obj['unread'];
    this.inq = obj['inq'];
    this.to = obj['to'];
    this.numbers = obj['numbers'];
  }
}

class UnreadsStore extends FusionStore<UnreadMessage> {
  String id_field = "id";

  UnreadsStore(FusionConnection fusionConnection) : super(fusionConnection);

  getUnreads(Function(List<UnreadMessage>, bool) callback) {
    fusionConnection.apiV2Call("get", "/messaging/unread", {},
        callback: (Map<String, dynamic> datas) {
          List<UnreadMessage> response = [];

          for (Map<String, dynamic> item in datas['items']) {
            UnreadMessage obj = UnreadMessage(item);
            storeRecord(obj);
            response.add(obj);
          }

          callback(response, true);
        });
  }

  hasUnread() {
    print("UNREAD COUNT" + this.getRecords().length.toString());
    return false;

    return this.getRecords().length > 0;
  }
}
