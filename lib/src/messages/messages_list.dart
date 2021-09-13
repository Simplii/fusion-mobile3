import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import 'message_search_results.dart';
import 'sms_conversation_view.dart';

class MessagesTab extends StatefulWidget {
  final FusionConnection _fusionConnection;

  MessagesTab(this._fusionConnection, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  SMSConversation openConversation = null;
  bool showingResults = false;
  List<SMSConversation> _convos = [];
  List<CrmContact> _crmContacts = [];
  List<Contact> _contacts = [];
  String _myNumber = "8014569812";

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    //if (openConversation == null) {
    children = [
      SearchMessagesView(_fusionConnection, (List<SMSConversation> convos,
          List<CrmContact> crmContacts, List<Contact> contacts) {
        this.setState(() {
          showingResults = true;
          _convos = convos;
          _crmContacts = crmContacts;
          _contacts = contacts;
        });
      }, () {
        this.setState(() {
          showingResults = false;
        });
      }),
      showingResults
          ? Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  padding:
                      EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
                  child: MessageSearchResults(_myNumber, _convos, _contacts,
                      _crmContacts, _fusionConnection)))
          : MessagesList(_fusionConnection)
    ];
    /*}
    else {
      children = [
        SMSConversationView(_fusionConnection, openConversation)
      ];
    }*/

    return Container(child: Column(children: children));
  }
}

class MessagesList extends StatefulWidget {
  final FusionConnection _fusionConnection;

  MessagesList(this._fusionConnection, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<SMSConversation> _convos = [];

  _lookupMessages() {
    lookupState = 1;
    _fusionConnection.conversations.getConversations(-2,
        (List<SMSConversation> convos) {
      this.setState(() {
        lookupState = 2;
        _convos = convos;
      });
    });
  }

  _messagesList() {
    return _convos.map((convo) {
      return SMSConversationSummaryView(_fusionConnection, convo);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (lookupState == 0) {
      _lookupMessages();
    }
    print("lookupstate : " + lookupState.toString());
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("ALL MESSAGES", style: headerTextStyle))),
              Expanded(
                  child: CustomScrollView(slivers: [
                SliverList(delegate: SliverChildListDelegate(_messagesList()))
              ]))
            ])));
  }
}

class SMSConversationSummaryView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSConversation _convo;

  SMSConversationSummaryView(this._fusionConnection, this._convo, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SMSConversationSummaryViewState();
}

class _SMSConversationSummaryViewState
    extends State<SMSConversationSummaryView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  SMSConversation get _convo => widget._convo;
  final _searchInputController = TextEditingController();

  _openConversation() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(_fusionConnection, _convo));
  }

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(_convo.message.unixtime * 1000);

    return Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Row(children: [
          ContactCircle(_convo.contacts, _convo.crmContacts),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    _openConversation();
                  },
                  child: Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_convo.contactName(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 243, 242, 242),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            padding: EdgeInsets.only(
                                left: 6, right: 6, top: 2, bottom: 2),
                            child: Text(
                                DateFormat("MMM d").format(date) +
                                    " \u2014 " +
                                    _convo.message.message,
                                style: smallTextStyle,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis)))
                  ])))
        ]));
  }
}

class SearchMessagesView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Function() _onClearSearch;
  final Function(List<SMSConversation>, List<CrmContact>, List<Contact>)
      _onHasResults;

  SearchMessagesView(
      this._fusionConnection, this._onHasResults, this._onClearSearch,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchMessagesViewState();
}

class _SearchMessagesViewState extends State<SearchMessagesView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  final _searchInputController = TextEditingController();

  _openMenu() {}

  String groupId = "-1";
  String myPhoneNumber = "8014569812";
  String _query = "";
  int willSearch = 0;

  Function() get _onClearSearch => widget._onClearSearch;

  Function(List<SMSConversation>, List<CrmContact>, List<Contact>)
      get _onHasResults => widget._onHasResults;

  _search(String val) {
    if (_searchInputController.value.text.trim() == "") {
      this._onClearSearch();
    }
    if (willSearch == 0) {
      willSearch = 1;
      Future.delayed(const Duration(seconds: 1)).then((dynamic x) {
        String query = _searchInputController.value.text;

        _fusionConnection.messages.search(query, (List<SMSConversation> convos,
            List<CrmContact> crmContacts, List<Contact> contacts) {
          willSearch = 0;

          if (mounted) {
            this._onHasResults(convos, crmContacts, contacts);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Container(
            padding: EdgeInsets.only(left: 4, right: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color.fromARGB(85, 0, 0, 0)),
            child: Row(children: [
              Container(
                height: 24,
                width: 36,
                margin: EdgeInsets.all(0),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Image.asset("assets/icons/hamburger.png",
                      height: 30, width: 45),
                  //constraints: BoxConstraints(maxHeight: 12, maxWidth: 18),
                  onPressed: _openMenu,
                ),
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 12),
                      height: 38,
                      child: TextField(
                          onChanged: _search,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 154, 148, 149)),
                              hintText: "Search"),
                          controller: _searchInputController)))
            ])));
  }
}
