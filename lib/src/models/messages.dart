import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'carbon_date.dart';
import 'fusion_model.dart';
import 'crm_contact.dart';
import 'contact.dart';
import '../backend/fusion_connection.dart';
import 'fusion_store.dart';

class SMSMessage extends FusionModel {
  bool convertedMms;
  String domain;
  String from;
  bool fromMe;
  String id;
  bool isGroup;
  bool media;
  String message;
  String messageStatus;
  String mime;
  bool read;
  CarbonDate scheduledAt;
  int smsWebhookId;
  CarbonDate time;
  String to;
  String type;
  int unixtime;
  String user;

  SMSMessage(Map<String, dynamic> map) {
    this.convertedMms = map.containsKey('converted_mms') ? true : false;
    this.domain = map['domain'];
    this.from = map['from'];
    this.fromMe = map['from_me'];
    this.id = map['id'].toString();
    this.isGroup = map['is_group'];
    this.media = map['media'];
    this.message = map['message'];
    this.messageStatus = map['message_status'];
    this.mime = map['mime'];
    this.read = map['read'] == "1";
    this.scheduledAt = ((map.containsKey('scheduled_at') && map['scheduled_at'].runtimeType == Map)
        ? CarbonDate(map['scheduled_at'])
        : null);
    this.smsWebhookId = map['sms_webhook_id'].runtimeType == int
        ? map['sms_webhook_id']
        : 0;
    this.time = CarbonDate(map['time']);
    this.to = map['to'];
    this.type = map['type'];
    this.unixtime = map['unixtime'];
    this.user = map['user'];
  }
}