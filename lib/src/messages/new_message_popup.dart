import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';

import '../backend/fusion_connection.dart';
import '../components/fusion_dropdown.dart';
import '../styles.dart';
import '../utils.dart';
import 'message_search_results.dart';

class NewMessagePopup extends StatefulWidget {
  final FusionConnection _fusionConnection;

  NewMessagePopup(this._fusionConnection, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewMessagePopupState();
}

class _NewMessagePopupState extends State<NewMessagePopup> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  final _searchTextController = TextEditingController();
  int willSearch = 0;
  List<SMSConversation> _convos = [];
  List<CrmContact> _crmContacts = [];
  List<Contact> _contacts = [];
  String groupId = "-1";
  String myPhoneNumber = "8014569812";
  String _query = "";

  _search() {
    if (willSearch == 0) {
      willSearch = 1;
      Future.delayed(const Duration(seconds: 1)).then((dynamic x) {
        String query = _searchTextController.value.text;
        willSearch = 0;
        _fusionConnection.messages.search(query, (List<SMSConversation> convos,
            List<CrmContact> crmContacts, List<Contact> contacts) {
          willSearch = 0;

          if (mounted) {
            this.setState(() {
              _convos = convos;
              _crmContacts = crmContacts;
              _contacts = contacts;
            });
          }
        });
      });
    }
  }

  _header() {
    String myImageUrl = _fusionConnection.myAvatarUrl();

    return Column(children: [
      Center(child: popupHandle()),
      Row(children: [
        Text("FROM " + mDash + " ", style: subHeaderTextStyle),
        FusionDropdown(
            onChange: (String value) {
              this.setState(() {
                groupId = value;
              });
            },
            label: "Who are you representing?",
            value: groupId,
            options: [
              ["MYSELF", "-1"]
            ])
      ]),
      Row(children: [
        Text("USING " + mDash + " ", style: subHeaderTextStyle),
        FusionDropdown(
            onChange: (String value) {
              this.setState(() {
                myPhoneNumber = value;
              });
            },
            label: "From which phone number?",
            value: myPhoneNumber,
            options: [
              ["8014569812".formatPhone(), "8014569812"]
            ])
      ]),
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 12),
                height: 40,
                child: TextField(
                    controller: _searchTextController,
                    onChanged: _search(),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 153, 148, 149),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        hintText: "Enter a name or phone number"),
                    style: TextStyle(
                        color: coal,
                        fontSize: 18,
                        fontWeight: FontWeight.w700))))
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    List<SMSConversation> convoResults = [];
    String query =
        _searchTextController.value.text.replaceAll(RegExp(r'[^0-9]+'), '');
    if (query.length >= 10) {
      convoResults
          .add(SMSConversation.build(myNumber: myPhoneNumber, number: query));
    }
    convoResults.addAll(_convos);

    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.only(top: 80, bottom: 0),
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  color: particle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              padding:
                  EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 12),
              child: _header()),
          Row(children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 221, 221)),
                    height: 1))
          ]),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Container(
                      child: convoResults.length > 0
                          ? MessageSearchResults(myPhoneNumber, convoResults,
                              _contacts, _crmContacts, _fusionConnection)
                          : Container())))
        ]));
  }
}
