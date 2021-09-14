import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import '../utils.dart';

class SMSConversationView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSConversation _smsConversation;

  SMSConversationView(this._fusionConnection, this._smsConversation, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SMSConversationViewState();
}

class _SMSConversationViewState extends State<SMSConversationView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  SMSConversation get _conversation => widget._smsConversation;
  TextEditingController _messageInputController = TextEditingController();
  bool _loaded = false;

  initState() {
    if (_fusionConnection.smsDepartments.lookupRecord("-2") != null) {
      _loaded = true;
    }
    _fusionConnection.smsDepartments.getDepartments((List<SMSDepartment> list) {
      this.setState(() { _loaded = true; });
    });
  }

  _header() {
    String myImageUrl = _fusionConnection.myAvatarUrl();

    return Column(children: [
      Center(
          child: Container(
              decoration: BoxDecoration(
                  color: halfSmoke,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              width: 36,
              height: 5)),
      Row(children: [
        ContactCircle(_conversation.contacts, _conversation.crmContacts),
        Expanded(
            child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(_conversation.contactName(), style: headerTextStyle)),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(_conversation.number.formatPhone(),
                  style: subHeaderTextStyle))
        ])),
        IconButton(
            icon: Image.asset(
              "assets/icons/phone.png",
              width: 20,
              height: 20,
            ),
            onPressed: () {}),
        IconButton(
            iconSize: 32,
            icon: Image.asset(
              "assets/icons/three_dots.png",
              width: 4,
              height: 16,
            ),
            onPressed: () {})
      ]),
      Row(children: [horizontalLine(16)]),
      Row(children: [
        Expanded(
          child: Container()),
        Container(
          child: Align(
              alignment: Alignment.centerRight, child: _myNumberDropdown()),
        ),
        Align(alignment: Alignment.centerRight, child: _theirNumberDropdown()),
        Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    fit: BoxFit.fill,
                        image: (myImageUrl != null
                                ? NetworkImage(myImageUrl)
                                : Image.asset("assets/blank_avatar.png",
                                                  height: 32, width: 32)))))))
      ])
    ]);
  }

  _allMyNumbers() {
    SMSDepartment dept = _fusionConnection.smsDepartments.lookupRecord("-2");
    List<List<String>> opts = [];

    for (String number in dept.numbers) {
      opts.add([number.formatPhone(), number.onlyNumbers()]);
    }

    return opts;
  }

  _allTheirNumbers() {
    List<List<String>> opts = [];
    Map<String, String> numbers = {
      _conversation.number.onlyNumbers() : _conversation.number.onlyNumbers()};

    for (Contact c in _conversation.contacts) {
      if (c.phoneNumbers != null) {
        for (Map<String, dynamic> number in c.phoneNumbers) {
          numbers[number['number'].onlyNumbers()] = number['number'];
        }
      }
    }

    for (CrmContact c in _conversation.crmContacts) {
      if (c.phone_number != null) {
        numbers[c.phone_number.onlyNumbers()] = c.phone_number;
      }
    }

    for (String number in numbers.keys) {
      opts.add([number.formatPhone(), number.onlyNumbers()]);
    }

    return opts;
  }

  _myNumberDropdown() {
    return Container(
        decoration: dropdownDecoration,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 8),
        height: 36,
        child: FusionDropdown(
            value: _conversation.myNumber,
            options: _allMyNumbers(),
            onChange: (String newNumber) {
              this.setState(() {
                _conversation.myNumber = newNumber; });
            },
            label: "Your phone number"));
  }

  _theirNumberDropdown() {
    return Container(
        decoration: dropdownDecoration,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 8),
        height: 36,
        child: FusionDropdown(
          value: _conversation.number,
          options: _allTheirNumbers(),
          onChange: (String newNumber) {
            this.setState(() {
              _conversation.number = newNumber;
            });
          },
          label: "Their phone number"
        ));
  }

  _sendMessageInput() {
    return Container(
        height: 64,
        decoration: BoxDecoration(color: particle),
        padding: EdgeInsets.only(top: 12, left: 8, bottom: 12, right: 8),
        child: Row(children: [
          Expanded(
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 229, 227, 227), width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                  child: TextField(
                    controller: _messageInputController,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 14, right: 14, top: -10),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 153, 148, 149)),
                        hintText: "Message"),
                  ))),
          Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(left: 8),
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon:
                    Image.asset("assets/icons/send.png", height: 40, width: 40),
                onPressed: _sendMessage,
              ))
        ]));
  }

  _sendMessage() {
    _fusionConnection.messages
        .sendMessage(_messageInputController.value.text, _conversation);
    _messageInputController.text = "";
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
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            color: particle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        padding: EdgeInsets.only(
                            top: 10, left: 14, right: 14, bottom: 12),
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
                            child: Row(children: [
                              Expanded(
                                  child: _loaded
                                         ? ConvoMessagesList(
                                      _fusionConnection, _conversation)
                                         : Container())
                            ]))),
                  ]))),
          _sendMessageInput()
        ]),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom));
  }
}

class ConvoMessagesList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSConversation _conversation;

  ConvoMessagesList(this._fusionConnection, this._conversation, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConvoMessagesListState();
}

class _ConvoMessagesListState extends State<ConvoMessagesList> {
  SMSConversation get _conversation => widget._conversation;
  FusionConnection get _fusionConnection => widget._fusionConnection;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<SMSMessage> _messages = [];
  String _subscriptionKey;

  String _lookedupNumber = "";
  String _lookedupMyNumber = "";

  @override
  dispose() {
    super.dispose();
    _clearSubscription();
  }

  _clearSubscription() {
    if (_subscriptionKey != null) {
      _fusionConnection.messages.clearSubscription(_subscriptionKey);
      _subscriptionKey = null;
    }
  }

  _addMessage(SMSMessage message) {
    bool matched = false;

    for (SMSMessage savedMessage in _messages) {
      if (savedMessage.id == message.id) {
        matched = true;
      }
    }

    if (!matched) {
      _messages.add(message);
    }
  }

  @override
  _lookupMessages() {
    lookupState = 1;
    _clearSubscription();
    _subscriptionKey = _fusionConnection.messages.subscribe(_conversation,
        (List<SMSMessage> messages) {
      this.setState(() {
        for (SMSMessage m in messages) {
          _addMessage(m);
        }
      });
    });
    _fusionConnection.messages.getMessages(_conversation, 200, 0,
        (List<SMSMessage> messages) {
      this.setState(() {
        lookupState = 2;
        _messages = messages;
      });
    });
  }

  _messagesList() {
    List<Widget> list = [];
    DateTime lastDate;
    Widget toAdd;

    _messages.sort((SMSMessage m1, SMSMessage m2) {
      return m1.unixtime > m2.unixtime ? -1 : 1;
    });

    for (SMSMessage msg in _messages) {
      DateTime thisTime =
          DateTime.fromMillisecondsSinceEpoch(msg.unixtime * 1000);

      if (lastDate == null ||
          thisTime.difference(lastDate).inHours.abs() > 24) {
        lastDate = thisTime;

        if (toAdd != null) {
          list.add(toAdd);
        }

        toAdd = Row(children: [
          horizontalLine(8),
          Container(
              margin: EdgeInsets.only(left: 4, right: 4, bottom: 12, top: 12),
              child: Text(
                DateFormat("E MMM d, y").format(thisTime),
                style: TextStyle(
                    color: char, fontSize: 12, fontWeight: FontWeight.w700),
              )),
          horizontalLine(8)
        ]);
      }
      list.add(SMSMessageView(_fusionConnection, msg, _conversation));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    print("building here " + lookupState.toString() + ":" + _lookedupNumber.toString() + ":" + _lookedupMyNumber.toString());
    if (lookupState != 0
        && (_conversation.number != _lookedupNumber
            || _conversation.myNumber != _lookedupMyNumber)) {
      lookupState = 0;
      _messages = [];
    }

    if (lookupState == 0) {
      _lookedupNumber = _conversation.number;
      _lookedupMyNumber = _conversation.myNumber;
      _lookupMessages();
    }


    return ListView(children: _messagesList(), reverse: true);
  }
}

class SMSMessageView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSMessage _message;
  final SMSConversation _conversation;

  SMSMessageView(this._fusionConnection, this._message, this._conversation,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SMSMessageViewState();
}

class _SMSMessageViewState extends State<SMSMessageView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  SMSConversation get _conversation => widget._conversation;

  SMSMessage get _message => widget._message;
  final _searchInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(_message.unixtime * 1000);

    List<Widget> children = [];

    if (_message.from != _conversation.myNumber) {
      children.add(ContactCircle.withDiameter(
          _conversation.contacts, _conversation.crmContacts, 44));
      children.add(Expanded(
          child: Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(DateFormat.jm().format(date),
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w800, color: smoke))),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: coal,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )),
                child: Text(_message.message,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: Colors.white))))
      ])));
    } else {
      children.add(Expanded(
          child: Column(children: [
        Align(
            alignment: Alignment.centerRight,
            child: Text(DateFormat.jm().format(date),
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w800, color: smoke))),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: particle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )),
                child: Text(_message.message,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: coal))))
      ])));
    }

    return Container(
        decoration: BoxDecoration(color: Colors.white),
        margin: EdgeInsets.only(bottom: 18),
        child: Row(children: children));
  }
}
