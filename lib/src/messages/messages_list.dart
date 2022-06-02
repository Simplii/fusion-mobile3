import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import 'message_search_results.dart';
import 'sms_conversation_view.dart';

class MessagesTab extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  MessagesTab(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;
  SMSConversation openConversation = null;
  bool showingResults = false;
  List<SMSConversation> _convos = [];
  List<CrmContact> _crmContacts = [];
  List<Contact> _contacts = [];
  String _myNumber = "";
  bool _loaded = false;

  initState() {
    super.initState();
    if (_fusionConnection.smsDepartments.lookupRecord("-2") != null) {
      _loaded = true;
    }
    _fusionConnection.smsDepartments.getDepartments((List<SMSDepartment> list) {
      if (!mounted) return;
      this.setState(() {
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    //if (openConversation == null) {
    children = [
      SearchMessagesView(_fusionConnection, (List<SMSConversation> convos,
          List<CrmContact> crmContacts, List<Contact> contacts) {
        if (!mounted) return;
        this.setState(() {
          showingResults = true;
          _convos = convos;
          _crmContacts = crmContacts;
          _contacts = contacts;
        });
      }, () {
        if (!mounted) return;
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
                      _crmContacts, _fusionConnection, _softphone)))
          : _loaded
              ? MessagesList(_fusionConnection, _softphone)
              : Container()
    ];

    return Container(child: Column(children: children));
  }
}

class MessagesList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  MessagesList(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<SMSConversation> _convos = [];
  String _selectedGroupId = "-2";
  int _page = 0;

  _loadMore() {
    if (_page >= 0 && lookupState != 1) {
      _page += 1;
      _lookupMessages();
    }
  }

  _getDepartmentName(convo) {
    if (_selectedGroupId != "-2")
      return "";
    else {
      SMSDepartment department = _fusionConnection.smsDepartments
          .getDepartmentByPhoneNumber(convo.myNumber);

      if (department != null)
        return department.groupName;
      else
        return "";
    }
  }

  _lookupMessages() {
    lookupState = 1;
    _fusionConnection.conversations
        .getConversations(_selectedGroupId, 100, _page * 100,
            (List<SMSConversation> convos, bool fromServer) {
      if (!mounted) return;
      this.setState(() {
        if (fromServer != null && fromServer) {
          lookupState = 2;
        }

        if (_page == 0) {
          _convos = convos;
        } else {
          Map<String, SMSConversation> allconvos = {};
          for (SMSConversation s in _convos) allconvos[s.getId()] = s;
          for (SMSConversation s in convos) allconvos[s.getId()] = s;
          _convos = allconvos.values.toList().cast<SMSConversation>();
        }

        _convos.sort((SMSConversation a, SMSConversation b) {
          return DateTime.parse(a.lastContactTime)
                  .isAfter(DateTime.parse(b.lastContactTime))
              ? -1
              : 1;
        });

        if (convos.length < 100 && fromServer) {
          _page = -1;
        }
      });
    });
  }

  _messagesList() {
    return _convos.map((convo) {
      return SMSConversationSummaryView(
          _fusionConnection, _softphone, convo, _getDepartmentName(convo));
    }).toList();
  }

  _changeGroup(String newGroupId) {
    _selectedGroupId = newGroupId;
    _page = 0;
    _lookupMessages();
  }

  _selectedDepartmentName() {
    return _fusionConnection.smsDepartments
        .getDepartment(_selectedGroupId)
        .groupName;
  }

  _groupOptions() {
    List<SMSDepartment> departments =
        _fusionConnection.smsDepartments.allDepartments();
    List<List<String>> options = [];

    departments.sort((a, b) => a.groupName.compareTo(b.groupName));

    for (SMSDepartment d in departments) {
      options.add([d.groupName, d.id]);
    }
    return options;
  }

  _spinner() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 24, top: 24, left: 48, right: 48),
        child: Center(child: SpinKitThreeBounce(color: smoke, size: 50)));
  }

  _isSpinning() {
    return lookupState < 2 && _convos.length == 0;
  }

  @override
  Widget build(BuildContext context) {
    if (lookupState == 0) {
      _lookupMessages();
    }
print("render convos");
    print(_convos);
    print(_convos.length);
    print(_page);
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            padding: EdgeInsets.all(0),
            //EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
            child: Stack(children: [
              Column(children: [
                Expanded(
                    child: this._isSpinning()
                        ? this._spinner()
                        : ListView.builder(
                            itemCount: _page == -1
                                ? _convos.length + 2
                                : _convos.length + 2,
                            itemBuilder: (BuildContext context, int index) {
                              print('build');
                              print(index);
                              print(_convos.length);

                              if (index == 0) {
                                return Container(height: 60);
                              } else if (index - 1 > _convos.length &&
                                  lookupState != 1) {
                                _loadMore();
                                return Container(height: 30);
                              } else if (_convos.length > index - 1) {
                                print(_convos[index - 1]);
                                return SMSConversationSummaryView(
                                    _fusionConnection,
                                    _softphone,
                                    _convos[index - 1],
                                    _getDepartmentName(_convos[index - 1]));
                              } else {
                                return Container();
                              }
                            }))
              ]),
              Container(
                  height: 80,
                  padding:
                      EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
                  decoration: BoxDecoration(
                      boxShadow: [],
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1.0],
                          colors: [Colors.white, translucentWhite(0.0)])),
                  margin: EdgeInsets.only(bottom: 24),
                  child: Row(children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(_selectedDepartmentName().toUpperCase(),
                                style: headerTextStyle))),
                    FusionDropdown(
                        onChange: _changeGroup,
                        value: _selectedGroupId,
                        options: _groupOptions(),
                        label: "Select a Department",
                        button: Container(
                          decoration: BoxDecoration(
                              color: translucentSmoke,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 8, right: 9, left: 9),
                          width: 32,
                          height: 32,
                          child: Image.asset(
                            "assets/icons/down_chevron.png",
                            width: 12,
                            height: 6,
                          ),
                        ))
                  ])),
            ])));
  }
}

class SMSConversationSummaryView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final SMSConversation _convo;
  final String _departmentName;

  SMSConversationSummaryView(this._fusionConnection, this._softphone,
      this._convo, this._departmentName,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SMSConversationSummaryViewState();
}

class _SMSConversationSummaryViewState
    extends State<SMSConversationSummaryView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  String get _departmentName => widget._departmentName;

  SMSConversation get _convo => widget._convo;
  final _searchInputController = TextEditingController();

  _openConversation() {
    _fusionConnection.conversations.markRead(_convo);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            SMSConversationView(_fusionConnection, _softphone, _convo));
  }

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(_convo.message.unixtime * 1000);

    return GestureDetector(
        onTap: () {
          _openConversation();
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 18, left: 16, right: 16),
            child: Row(children: [
              ContactCircle(_convo.contacts, _convo.crmContacts),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_convo.contactName(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 242, 242),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 6, right: 6, top: 2, bottom: 2),
                                    child: Text(
                                        DateFormat("MMM d").format(date) +
                                            (_departmentName != ""
                                                ? " " +
                                                    nDash +
                                                    " " +
                                                    _departmentName
                                                : "") +
                                            " \u2014 " +
                                            _convo.message.message,
                                        style: smallTextStyle,
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis)))
                          ])),
                          if (_convo.unread > 0)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: 8.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: informationBlue),
                            )
                        ],
                      )))
            ])));
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

  _openMenu() {
    Scaffold.of(context).openDrawer();
  }

  String groupId = "-1";
  String myPhoneNumber = "8014569812";
  String _query = "";
  int willSearch = 0;
  String _searchingFor;

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
        willSearch = 0;

        String query = _searchInputController.value.text;
        _searchingFor = query;

        _fusionConnection.messages.search(query, (List<SMSConversation> convos,
            List<CrmContact> crmContacts, List<Contact> contacts) {
          if (mounted && query == _searchingFor) {
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
