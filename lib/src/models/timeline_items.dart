import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'contact.dart';
import 'coworkers.dart';
import 'crm_contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';
import 'messages.dart';

class CallLog {
  DateTime startTime;
  DateTime endTime;
  int duration;
  String type;
  String to;
  String from;
  String recording;
  String note;
  String disposition;
}

class TimelineItem extends FusionModel {
  String id;
  DateTime time;
  String phoneNumber;
  String type;
  SMSMessage message;
  CallLog callLog;

  TimelineItem(Map<String, dynamic> obj) {
    print("importing" + obj.toString());
      time = obj.containsKey('time')
        ? DateTime.parse(obj['time']['date'])
        : (obj.containsKey('time_start')
        ? DateTime.fromMillisecondsSinceEpoch(int.parse(obj['time_start']) * 1000)
        : DateTime.fromMillisecondsSinceEpoch(0));
    type = obj.containsKey('recording')
        ? 'call'
        : (obj.containsKey('converted_mms') ? 'message' : '');
    id = type + ':' + obj['id'].toString();

    if (type == 'message') {
      message = SMSMessage(obj);
    }
    else {
      callLog = CallLog();
      callLog.startTime = time;
      callLog.endTime = DateTime.fromMillisecondsSinceEpoch(int.parse(obj['time_end'].toString()) * 1000);
      callLog.duration = obj['length'];
      callLog.type = obj['type'];
      callLog.from = obj['from'];
      callLog.to = obj['to'];
      callLog.recording = obj['recording'].runtimeType == String ? obj['recording'] : null;
      callLog.note = obj['note'];
      callLog.disposition = obj['disposition'].runtimeType == String ? obj['disposition'] : null;
      if (callLog.note == '')
        callLog.note = null;
      if (callLog.type == 'Outgoing')
        phoneNumber = obj['to_did'];
      else
        phoneNumber = obj['from_did'];
    }
  }

  @override
  String getId() => this.id;
}

class TimelineItemStore extends FusionStore<TimelineItem> {
  String id_field = "id";
  TimelineItemStore(FusionConnection fusionConnection) : super(fusionConnection);

  getTimeline(int contactId,
      Function(List<TimelineItem>, bool) callback) {
    fusionConnection.apiV1Call(
        "get",
        "/contacts/" + contactId.toString() + "/timeline",
        {},
        callback: (List<dynamic> datas) {
          List<TimelineItem> response = [];

          for (Map<String, dynamic> item in datas) {
            TimelineItem obj = TimelineItem(item);
            if (obj.type == 'message')
              obj.phoneNumber = (obj.message.domain == fusionConnection.getDomain()
                  ? obj.message.to : obj.message.from);
            storeRecord(obj);
            response.add(obj);
          }

          callback(response, true);
        });
  }


  getTimelineFromNumbers(List<String> numbers,
      Function(List<TimelineItem>, bool) callback) {
    callback(getRecords()
        .where((TimelineItem item) => numbers.contains(item.phoneNumber))
        .toList()
        .cast<TimelineItem>(), false);

    fusionConnection.apiV1Call(
        "post",
        "/contacts/timeline",
        {'numbers': numbers},
        callback: (List<dynamic> datas) {
          List<TimelineItem> response = [];

          for (Map<String, dynamic> item in datas) {
            TimelineItem obj = TimelineItem(item);
            if (obj.type == 'message')
              obj.phoneNumber = (obj.message.domain == fusionConnection.getDomain()
                  ? obj.message.to : obj.message.from);
            storeRecord(obj);
            response.add(obj);
          }

          callback(response, true);
        });
  }
}