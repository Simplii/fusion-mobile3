import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import 'fusion_model.dart';
import 'fusion_store.dart';

class Did extends FusionModel {
  String callRoutingUser;
  String did;
  bool mmsCapable;
  String notes;
  String groupName;
  // smsRouting: null OR {groupId, type} OR {uid, type}

  Did(Map<String, dynamic> obj) {
    this.callRoutingUser = obj['callRoutingUser'];
    this.did = obj['did'];
    this.mmsCapable = obj['mmsCapable'];
    this.notes = obj['notes'];
    this.groupName = obj.containsKey("groupName") ? obj["groupName"] : null;
  }
}

class DidStore extends FusionStore<Did> {
  String id_field = "did";

  DidStore(FusionConnection fusionConnection) : super(fusionConnection);

  getDids(Function(List<Did>, bool) callback) {
    fusionConnection.apiV2Call("get", "/clients/numbers", {},
        callback: (Map<String, dynamic> datas) {
      List<Did> response = [];

      for (Map<String, dynamic> item in datas['items']) {
        Did obj = Did(item);
        storeRecord(obj);
        response.add(obj);
      }

      callback(response, true);
    });
  }
}
