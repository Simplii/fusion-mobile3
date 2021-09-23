import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';

import '../backend/fusion_connection.dart';
import '../components/fusion_dropdown.dart';
import '../styles.dart';
import '../utils.dart';
import 'message_search_results.dart';
import 'sms_conversation_view.dart';

class NewMessagePopup extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  NewMessagePopup(this._fusionConnection, this._softphone, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewMessagePopupState();
}

class _NewMessagePopupState extends State<NewMessagePopup> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  final _searchTextController = TextEditingController();
  Softphone get _softphone => widget._softphone;
  int willSearch = 0;
  List<SMSConversation> _convos = [];
  List<CrmContact> _crmContacts = [];
  List<Contact> _contacts = [];
  String groupId = "-2";
  String myPhoneNumber = "";
  String _query = "";
  String _searchingFor = "";

  initState() {
    myPhoneNumber =
        _fusionConnection.smsDepartments.getDepartment("-2").numbers[0];
  }

  _search(String value) {
    if (willSearch == 0) {
      willSearch = 1;

      Future.delayed(const Duration(seconds: 1)).then((dynamic x) {
        willSearch = 0;
        String query = _searchTextController.value.text;

        if (query != _searchingFor) {
          _searchingFor = query;
          _fusionConnection.messages.search(query,
              (List<SMSConversation> convos, List<CrmContact> crmContacts,
                  List<Contact> contacts) {
            if (mounted && query == _searchingFor) {
              setState(() {
                _convos = convos;
                _crmContacts = crmContacts;
                _contacts = contacts;
              });
            }
          });
        }
      });
    }
  }

  _header() {
    String myImageUrl = _fusionConnection.myAvatarUrl();
    List<SMSDepartment> groups = _fusionConnection.smsDepartments.getRecords();

    return Column(children: [
      Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 12),
          child: popupHandle()),
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
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            options: groups
                .map((SMSDepartment d) {
                  return [d.groupName, d.id];
                })
                .toList()
                .cast<List<String>>()),
        Text("USING " + mDash + " ", style: subHeaderTextStyle),
        FusionDropdown(
            onChange: (String value) {
              this.setState(() {
                myPhoneNumber = value;
              });
            },
            label: "From which phone number?",
            value: myPhoneNumber,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            options: _fusionConnection.smsDepartments
                .lookupRecord(groupId)
                .numbers
                .map((String s) {
                  return [s.formatPhone(), s.onlyNumbers()];
                })
                .toList()
                .cast<List<String>>())
      ]),
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 16),
                height: 40,
                child: TextField(
                    controller: _searchTextController,
                    onChanged: _search,
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

  _startConvo(String number) {
    SMSConversation convo = SMSConversation.build(
      myNumber: myPhoneNumber,
      contacts: [],
      crmContacts: [],
      number: number,
    );
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(_fusionConnection, _softphone, convo));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    String query = "" + _searchTextController.value.text;
    query = query.replaceAll(RegExp(r'[^0-9]+'), '');
    bool isPhone = query.length == 10;

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
                  child: Column(children: [
                    isPhone
                        ? GestureDetector(
                            onTap: () {
                              _startConvo(query);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 80,
                                child: Text("Message this number \u2794",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: coal,
                                      fontWeight: FontWeight.w400,
                                    ))))
                        : Container(),
                    Expanded(child: Container(
                        child: _convos.length + _contacts.length + _crmContacts.length > 0
                            ? MessageSearchResults(myPhoneNumber, _convos,
                                _contacts, _crmContacts, _fusionConnection, _softphone)
                            : Container()))
                  ])))
        ]));
  }
}
