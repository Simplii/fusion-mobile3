import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/contacts/recent_contacts.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import '../utils.dart';

class TransferCallPopup extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final Function(String to, String type) _onTransfer;
  final Function() _goBack;

  TransferCallPopup(
      this._fusionConnection, this._softphone, this._goBack, this._onTransfer,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransferCallpopState();
}

class _TransferCallpopState extends State<TransferCallPopup> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  String _query = "";

  _doTransfer(String to) {
    widget._onTransfer(to, "blind");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        margin: EdgeInsets.only(top: 60),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(top: 8),
              child: Center(child: popupHandle())),
          if (_query == "")
            Expanded(child:Container(
                child: ContactsList(_fusionConnection, widget._softphone,
                    "Recent Coworkers", "coworkers",
                    onSelect: (Contact contact, CrmContact crmContact) {
              if (contact != null) {
                if (contact.firstNumber() != null)
                  _doTransfer(contact.firstNumber());
              } else if (crmContact != null) {
                if (crmContact.firstNumber() != null)
                  _doTransfer(crmContact.firstNumber());
              }
            }))),
          if (_query != "")
            Container(
                child: ContactsSearchList(_fusionConnection, widget._softphone,
                    this._query, "coworkers", embedded: true,
                    onSelect: (Contact contact, CrmContact crmContact) {
              if (contact != null) {
                if (contact.firstNumber() != null)
                  _doTransfer(contact.firstNumber());
              } else if (crmContact != null) {
                if (crmContact.firstNumber() != null)
                  _doTransfer(crmContact.firstNumber());
              }
            })),
          DialPad(_fusionConnection, widget._softphone,
              onPlaceCall: (String number) {
                  _doTransfer(number);
              },
              onQueryChange: (String query) {
            setState(() {
              _query = query;
            });
          })
        ]));
  }
}
