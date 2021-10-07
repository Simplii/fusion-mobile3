import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'contact.dart';
import 'coworkers.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';
import 'messages.dart';


class Voicemail extends FusionModel {
  String id;
  String path;
  DateTime time;
  String phoneNumber;
  int length;

  Voicemail(Map<String, dynamic> obj) {
    this.id = obj['index'];
    this.path = obj['remotepath'];
    this.phoneNumber = obj['FromUser'];
    this.length = obj['length'];
  }

  @override
  String getId() => this.id;
}

class VoicemailStore extends FusionStore<Voicemail> {
  String id_field = "id";

  VoicemailStore(FusionConnection fusionConnection) : super(fusionConnection);

  getVoicemails(Function(List<Voicemail>, bool) callback) {
    fusionConnection.nsApiCall(
        "audio",
        "read",
        {"limit": 200, "start": 0, "type": "vmail/new"},
        callback: (Map<String, dynamic> datas) {
          List<Voicemail> response = [];

          for (Map<String, dynamic> item in datas['music']) {
            Voicemail obj = Voicemail(item);
            storeRecord(obj);
            response.add(obj);
          }

          callback(response, true);
        });
  }
}
