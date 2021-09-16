import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import '../utils.dart';

class ContactProfileView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Contact _contact;

  ContactProfileView(this._fusionConnection, this._contact, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactProfileViewState();
}

class _ContactProfileViewState extends State<ContactProfileView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Contact get _contact => widget._contact;
  TextEditingController _messageInputController = TextEditingController();
  String _selectedTab = 'profile';
  String _selectedPhone = null;
  String _selectedEmail = null;

  _headerButton(String tabName, String iconName) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              this.setState(() {
                _selectedTab = tabName;
              });
            },
            child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                height: 40,
                margin: EdgeInsets.only(left: 30, right: 30, top: 8),
                child: Column(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                  "assets/icons/" +
                                      iconName +
                                      "_" +
                                      (_selectedTab == tabName
                                          ? 'dark'
                                          : 'light') +
                                      '.png',
                                  width: 20,
                                  height: 20)))),
                  bottomRedBar(_selectedTab != tabName)
                ]))));
  }

  _contactOccupation() {
    bool hasTitle = _contact.jobTitle != null && _contact.jobTitle != "";
    bool hasCompany = _contact.company != null && _contact.company != "";

    if (hasTitle && hasCompany)
      return _contact.jobTitle + " " + mDash + " " + _contact.company;
    else if (hasTitle && !hasCompany)
      return _contact.jobTitle;
    else if (!hasTitle && hasCompany)
      return _contact.company;
    else
      return null;
  }

  _header() {
    String occupation = _contactOccupation();
    String contactStatus = null;

    return Column(children: [
      Container(margin: EdgeInsets.all(8), child: Center(child: popupHandle())),
      Row(children: [
        _headerButton("profile", "user"),
        Container(
            margin: EdgeInsets.only(top: 12, bottom: 8),
            child: ContactCircle.withDiameterAndMargin([_contact], [], 74, 0)),
        _headerButton("timeline", "timeline")
      ]),
      Container(
          margin: EdgeInsets.only(top: 8),
          child: Align(
              alignment: Alignment.center,
              child: Text(_contact.name,
                  style: TextStyle(
                      color: coal,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)))),
      occupation == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(occupation,
                      style: TextStyle(
                          color: coal,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)))),
      contactStatus == null ? Container() : Row(children: [horizontalLine(0)]),
      contactStatus == null
          ? Container(height: 16)
          : Container(
              margin: EdgeInsets.all(8),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(contactStatus,
                      style: TextStyle(
                          color: coal,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)))),
    ]);
  }

  _getFieldGroups() {
    print("contact" + _contact.toString());
    List<Widget> phones = [];
    List<Widget> emails = [];

    return [
      _renderFieldGroup(
          "phone_filled_dark",
          _contact.phoneNumbers
              .map((number) {
                Map<String, dynamic> phone = number;
                return _renderField(
                    "phone",
                    number['type'] != null && number['type'] != null
                        ? number['type']
                        : 'Phone',
                    number['number'],
                    false);
              })
              .toList()
              .cast<Widget>()),
      _renderFieldGroup(
          "mail_filled_dark",
          _contact.emails
              .map((email) {
                Map<String, dynamic> mail = email;
                return _renderField(
                    "email",
                    email['type'] != null && email['type'] != null
                        ? email['type']
                        : 'Email',
                    email['email'],
                    false);
              })
              .toList()
              .cast<Widget>()),
    ].cast<Widget>();
  }

  _renderFieldGroup(String iconName, List<Widget> fields) {
    List<Widget> children = fields.toList();
    children.add(Container(
        margin: EdgeInsets.only(left:12, right: 16),
        child: Row(children: [horizontalLine(20)])));

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 20,
          width: 20,
          margin: EdgeInsets.only(left: 27, right: 16, top: 12),
          child: Image.asset("assets/icons/" + iconName + ".png",
              height: 20, width: 20)),
      Expanded(child: Column(children: children))
    ]);
  }

  _makeCall(String number) {}

  _openMessage(String theirNumber) {
    String number =
        _fusionConnection.smsDepartments.getDepartment("-2").numbers[0];

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(
            _fusionConnection,
            SMSConversation.build(
                contacts: [_contact],
                crmContacts: [],
                myNumber: number,
                number: theirNumber)));
  }

  _renderField(String type, String label, String value, bool selected) {
    if (type == "phone") {
      if (_selectedPhone == value)
        return GestureDetector(
            onTap: () {
              this.setState(() {
                _selectedPhone = null;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: particle,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                margin: EdgeInsets.only(top: 8, bottom: 8, right: 12),
                child: Column(children: [
                  _renderField("text", label, value.formatPhone(), true),
                  Row(children: [horizontalLine(0)]),
                  Container(
                      margin: EdgeInsets.only(
                          top: 12, bottom: 12, right: 12, left: 12),
                      child: Row(children: [
                        actionButton("Call", "phone_dark", 18, 18, () {
                          _makeCall(value);
                        }),
                        actionButton("Message", "message_dark", 18, 18, () {
                          _openMessage(value);
                        })
                      ]))
                ])));
      else
        return GestureDetector(
            onTap: () {
              this.setState(() {
                _selectedPhone = value;
              });
            },
            child: _renderField("text", label, value.formatPhone(), false));
    }
    else if (type == "text" || type == "email") {
      return Container(
          decoration: BoxDecoration(color: Colors.transparent),
          margin: EdgeInsets.only(top: 10, left: 12, bottom: 10, right: 12),
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(bottom: 4),
                alignment: Alignment.centerLeft,
                child: Text(value,
                    style: TextStyle(
                        color: coal,
                        fontSize: 16,
                        fontWeight: FontWeight.w700))),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(label,
                    style: TextStyle(
                        color: selected ? char : smoke,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)))
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    return Container(
        child: Column(children: [
      Expanded(
          child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              padding: EdgeInsets.only(top: 80, bottom: 0),
              child: Container(
                  decoration: BoxDecoration(
                      color: particle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Column(children: [
                    _header(),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                color: Colors.white),
                            child: ListView(
                                padding: EdgeInsets.only(top:12),
                                children: _getFieldGroups())))
                  ]))))
    ]));
  }
}
