import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/contacts/contact_profile_view.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';

class RecentCallsTab extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  RecentCallsTab(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecentCallsTabState();
}

class _RecentCallsTabState extends State<RecentCallsTab> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;
  SMSConversation openConversation = null;
  bool _showingResults = false;
  String _selectedTab = 'all';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    //if (openConversation == null) {
    children = [
      SearchCallsBar(_fusionConnection, (String query) {
        this.setState(() {
            _query = query;
        });
      }, () {
      }),
      Container(height: 4),
      Expanded(child: RecentCallsList(_fusionConnection, _softphone, "Recent Calls", _selectedTab,
          query: _query))
    ];
    return Container(child: Column(children: children));
  }
}

class RecentCallsList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final String _label;
  final String _selectedTab;
  final String query;
  final Function(Contact contact, CrmContact crmContact) onSelect;

  RecentCallsList(
      this._fusionConnection, this._softphone, this._label, this._selectedTab,
      {Key key, this.onSelect, this.query})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecentCallsListState();
}

class _RecentCallsListState extends State<RecentCallsList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  String get _label => widget._label;

  String get _selectedTab => widget._selectedTab;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<CallHistory> _history = [];
  String _lookedUpTab;
  String _subscriptionKey;
  Map<String, Coworker> _coworkers = {};

  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    if (_subscriptionKey != null) {
      _fusionConnection.coworkers.clearSubscription(_subscriptionKey);
    }
  }

  _lookupHistory() {
    lookupState = 1;
    _lookedUpTab = _selectedTab;

    if (_subscriptionKey != null) {
      _fusionConnection.coworkers.clearSubscription(_subscriptionKey);
    }

    _subscriptionKey =
        _fusionConnection.coworkers.subscribe(null, (List<Coworker> coworkers) {
      this.setState(() {
        for (Coworker c in coworkers) {
          _coworkers[c.uid] = c;
        }
      });
    });

    _fusionConnection.callHistory.getRecentHistory(300, 0,
        (List<CallHistory> history, bool fromServer) {
      this.setState(() {
        if (fromServer) {
          lookupState = 2;
        }
        _history = history;
      });
    });
  }

  _historyList() {
    List<Widget> response = [Container(height: 50)];
    response.addAll(_history.where((item) {
      String searchQuery = item.to + ":" + item.from + ":";

      if (item.contact != null)
        searchQuery += item.contact.searchString() + ":";

      if (item.crmContact != null)
        searchQuery += item.crmContact.company + ":" + item.crmContact.name + ":" + item.crmContact.crm;

      if (item.coworker != null)
        searchQuery += item.coworker.firstName + ':' + item.coworker.lastName;

      if (widget.query != "" && !searchQuery.contains(widget.query)) {
        return false;
      } else if (_selectedTab == 'all') {
        return true;
      } else if (_selectedTab == 'integrated') {
        return item.crmContact != null;
      } else if (_selectedTab == 'coworkers') {
        return item.coworker != null;
      } else if (_selectedTab == 'fusion') {
        return item.contact != null;
      } else {
        return false;
      }
    }).map((item) {
      if (item.coworker != null && _coworkers[item.coworker.uid] != null) {
        item.coworker = _coworkers[item.coworker.uid];
      }
      return CallHistorySummaryView(_fusionConnection, _softphone, item,
          onSelect: widget.onSelect == null
              ? null
              : () {
                  widget.onSelect(
                      item.coworker != null
                          ? item.coworker.toContact()
                          : item.contact,
                      item.crmContact);
                });
    }).toList());

    return response;
  }

  _spinner() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 24, top: 24, left: 48, right: 48),
        child: Center(child: SpinKitThreeBounce(color: smoke, size: 50)));
  }

  _isSpinning() {
    return lookupState < 2 && _history.length == 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_lookedUpTab != _selectedTab) {
      lookupState = 0;
    }
    if (lookupState == 0) {
      _lookupHistory();
    }

    return Container(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
            child: Stack(children: [
              Column(
                children: [
                  Expanded(
                      child: _isSpinning()
                          ? _spinner()
                          : Container(
                              padding: EdgeInsets.only(top: 00),
                              child: CustomScrollView(slivers: [
                                SliverList(
                                    delegate:
                                        SliverChildListDelegate(_historyList()))
                              ])))
                ],
              ),
              Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      boxShadow: [],
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1.0],
                          colors: [Colors.white, translucentWhite(0.0)])),
                  height: 60,
                  padding: EdgeInsets.only(
                    bottom: 24,
                    top: 12,
                    left: 16,
                  ),
                  child: Text(_label.toUpperCase(), style: headerTextStyle)),
            ])));
  }
}

class CallHistorySummaryView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final CallHistory _historyItem;
  final Softphone _softphone;
  Function() onSelect;

  CallHistorySummaryView(
      this._fusionConnection, this._softphone, this._historyItem,
      {Key key, this.onSelect})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallHistorySummaryViewState();
}

class _CallHistorySummaryViewState extends State<CallHistorySummaryView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  CallHistory get _historyItem => widget._historyItem;
  bool _expanded = false;

  List<Contact> _contacts() {
    if (_historyItem.contact != null) {
      return [_historyItem.contact];
    } else {
      return [];
    }
  }

  List<CrmContact> _crmContacts() {
    if (_historyItem.crmContact != null) {
      return [_historyItem.crmContact];
    } else {
      return [];
    }
  }

  _expand() {
    this.setState(() {
      _expanded = !_expanded;
    });
  }

  _name() {
    if (_historyItem.contact != null) {
      return _historyItem.contact.name;
    } else if (_historyItem.crmContact != null) {
      return _historyItem.crmContact.name;
    } else if (_historyItem.coworker != null) {
      return _historyItem.coworker.firstName +
          ' ' +
          _historyItem.coworker.lastName;
    } else {
      return _historyItem.toDid;
    }
  }

  _isMissed() {
    return _historyItem.missed && _historyItem.direction == "inbound";
  }

  _icon() {
    if (_historyItem.direction == 'outbound') {
      return "assets/icons/phone_outgoing.png";
    } else if (_isMissed()) {
      return "assets/icons/phone_missed_red.png";
    } else {
      return "assets/icons/phone_incoming.png";
    }
  }

  _openMessage() {
    String number =
        _fusionConnection.smsDepartments.getDepartment("-2").numbers[0];
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(
            _fusionConnection,
            _softphone,
            SMSConversation.build(
                contacts:
                    _historyItem.contact != null ? [_historyItem.contact] : [],
                crmContacts: _historyItem.crmContact != null
                    ? [_historyItem.crmContact]
                    : [],
                myNumber: number,
                number: _historyItem.direction == "outbound"
                    ? _historyItem.toDid
                    : _historyItem.fromDid)));
  }

  _makeCall() {
    _softphone.makeCall(_historyItem.direction == "inbound"
        ? _historyItem.fromDid
        : _historyItem.toDid);
  }

  _openProfile() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ContactProfileView(
            _fusionConnection, _softphone, _historyItem.contact));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [_topPart()];

    if (_expanded) {
      children.add(Container(
          child: Row(children: [horizontalLine(0)]),
          margin: EdgeInsets.only(top: 4, bottom: 4)));
      children.add(Container(
          height: 28,
          margin: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(children: [
            actionButton("Profile", "user_dark", 18, 18, _openProfile),
            actionButton("Call", "phone_dark", 18, 18, _makeCall),
            actionButton("Message", "message_dark", 18, 18, _openMessage)
            // _actionButton("Video", "video_dark", 18, 18, () {}),
          ])));
    }

    return Container(
        height: _expanded ? 132 : 76,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 0, left: 12, right: 12),
        decoration: _expanded
            ? BoxDecoration(
                color: particle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ))
            : null,
        child: Column(children: children));
  }

  _topPart() {
    return GestureDetector(
        onTap: () {
          if (widget.onSelect != null)
            widget.onSelect();
          else
            _expand();
        },
        child: Row(children: [
          ContactCircle.withCoworker(
              _contacts(), _crmContacts(), _historyItem.coworker),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_name(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(children: [
                          Container(
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                color: _expanded
                                    ? Colors.white
                                    : Color.fromARGB(255, 243, 242, 242),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 2, bottom: 2),
                              child: Row(children: [
                                Image.asset(_icon(), width: 12, height: 12),
                                Text(
                                    " " +
                                        mDash +
                                        " " +
                                        DateFormat.jm()
                                            .format(_historyItem.startTime),
                                    style: TextStyle(
                                        color:
                                            _isMissed() ? crimsonLight : coal,
                                        fontSize: 12,
                                        height: 1.4,
                                        fontWeight: FontWeight.w400))
                              ])),
                          Expanded(child: Container())
                        ]))
                  ])))
        ]));
  }
}

class SearchCallsBar extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Function() _onClearSearch;
  final Function(String query) _onChange;

  SearchCallsBar(this._fusionConnection, this._onChange, this._onClearSearch,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchCallsBarState();
}

class _SearchCallsBarState extends State<SearchCallsBar> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  final _searchInputController = TextEditingController();
  String _selectedTab;

  _openMenu() {
    Scaffold.of(context).openDrawer();
  }

  String _query = "";
  int willSearch = 0;

  Function() get _onClearSearch => widget._onClearSearch;

  Function(String query) get _onChange => widget._onChange;

  _search(String val) {
    Future.delayed(const Duration(seconds: 1)).then((dynamic x) {
      String query = _searchInputController.value.text.trim();
      _onChange(query);
    });
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
