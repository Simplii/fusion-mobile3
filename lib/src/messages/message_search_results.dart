import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import '../backend/fusion_connection.dart';
import '../utils.dart';
import '../styles.dart';
import 'package:intl/intl.dart';
import '../components/fusion_dropdown.dart';
import 'messages_list.dart';
import 'sms_conversation_view.dart';

class MessageSearchResults extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final List<SMSConversation> _conversations;
  final List<Contact> _contacts;
  final List<CrmContact> _crmContacts;
  final String _myNumber;

  MessageSearchResults(this._myNumber, this._conversations, this._contacts,
      this._crmContacts, this._fusionConnection,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageSearchResults();
}

class _MessageSearchResults extends State<MessageSearchResults> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  List<SMSConversation> get _conversations => widget._conversations;

  List<Contact> get _contacts => widget._contacts;

  List<CrmContact> get _crmContacts => widget._crmContacts;

  String get _myNumber => widget._myNumber;

  _openConvo(List<Contact> contacts, List<CrmContact> crmContacts) {
    String theirNumber = null;
    for (Contact c in contacts) {
      for (Map<String, dynamic> phone in c.phone_numbers) {
        theirNumber = phone['number'];
      }
    }
    for (CrmContact c in crmContacts) {
      if (c.phone_number != null) {
        theirNumber = c.phone_number;
      }
    }
    SMSConversation convo = SMSConversation.build(
      myNumber: _myNumber,
      contacts: contacts,
      crmContacts: crmContacts,
      number: theirNumber,
    );
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(_fusionConnection, convo));
  }

  _contactBubbles() {
    List<Widget> bubbles = [];
    for (Contact c in _contacts) {
      bubbles.add(GestureDetector(
          onTap: () {
            _openConvo([c], []);
          },
          child: Container(
              margin: EdgeInsets.only(top: 12),
              width: 72,
              child: Column(children: [
                ContactCircle.withDiameterAndMargin([c], [], 60, 0),
                Align(
                    alignment: Alignment.center,
                    child: Text(c.first_name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: coal,
                            fontSize: 12,
                            fontWeight: FontWeight.w700))),
                Align(
                    alignment: Alignment.center,
                    child: Text(c.last_name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: coal,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)))
              ]))));
    }
    for (CrmContact c in _crmContacts) {
      bubbles.add(GestureDetector(
          onTap: () {
            _openConvo([], [c]);
          },
          child: Container(
              width: 72,
              margin: EdgeInsets.only(top: 12),
              child: Column(children: [
                ContactCircle.withDiameterAndMargin([], [c], 60, 0),
                Text(c.name.split(r' ')[0],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: coal,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                Text(c.name.split(r' ').sublist(1).join(' '),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: coal, fontSize: 12, fontWeight: FontWeight.w700))
              ]))));
    }
    return bubbles;
  }

  _messagesList() {
    return _conversations.map((SMSConversation convo) {
      return SMSConversationSummaryView(_fusionConnection, convo);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 100,
          child: ListView(
              children: _contactBubbles(), scrollDirection: Axis.horizontal)),
      Container(
          padding: EdgeInsets.only(top: 14, bottom: 14),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Messages",
                  style: TextStyle(
                  color: coal, fontSize: 24, fontWeight: FontWeight.w700)))),
      Expanded(child: ListView(children: _messagesList()))
    ]);
  }
}
