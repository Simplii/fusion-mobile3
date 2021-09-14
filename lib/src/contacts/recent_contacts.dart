import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';

class RecentContactsTab extends StatefulWidget {
  final FusionConnection _fusionConnection;

  RecentContactsTab(this._fusionConnection, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecentContactsTabState();
}

class _RecentContactsTabState extends State<RecentContactsTab> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  SMSConversation openConversation = null;
  bool _showingResults = false;
  String _selectedTab = 'all';

  _getTitle() {
    return {
      'all': 'All Recents',
      'coworkers': 'Coworker Recents',
      'integrated': 'Integrated Recents',
      'fusion': 'Recent Contacts'
    }[_selectedTab];
  }

  _tabIcon(String name, String icon, double width, double height) {
    return Expanded(
        child: GestureDetector(
            onTapUp: (e) {
              print("tappedup" + name);
            },
            onTapDown: (e) {
              print("tappeddown" + name);
            },
            onTap: () {
              print("tapped" + name);
              this.setState(() {
                _selectedTab = name;
              });
            },
            child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Image.asset(
                          "assets/icons/" +
                              icon +
                              (_selectedTab == name ? '_selected' : '') +
                              ".png",
                          width: width,
                          height: height)),
                  Container(
                      height: 4,
                      decoration: BoxDecoration(
                          color: _selectedTab == name
                              ? crimsonLight
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(2),
                              topLeft: Radius.circular(2))))
                ]))));
  }

  _tabBar() {
    return Container(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Row(children: [
          _tabIcon("all", "all", 23, 20.5),
          _tabIcon("coworkers", "briefcase", 23, 20.5),
          _tabIcon("integrated", "integrated", 23, 20.5),
          _tabIcon("fusion", "personalcontact", 23, 20.5),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    //if (openConversation == null) {
    children = [
      SearchContactsBar(_fusionConnection, (String query) {}, () {
        this.setState(() {
          _showingResults = false;
        });
      }),
      _tabBar(),
      ContactsList(_fusionConnection, _getTitle(), _selectedTab)
    ];
    return Container(child: Column(children: children));
  }
}

class ContactsList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final String _label;
  final String _selectedTab;

  ContactsList(this._fusionConnection, this._label, this._selectedTab,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  String get _label => widget._label;

  String get _selectedTab => widget._selectedTab;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<CallHistory> _history = [];
  String _lookedUpTab;

  initState() {
    super.initState();
  }

  _lookupHistory() {
    lookupState = 1;
    _lookedUpTab = _selectedTab;
    _fusionConnection.callHistory.getRecentHistory(0, 300,
        (List<CallHistory> history) {
      this.setState(() {
        lookupState = 2;
        _history = history;
      });
    });
  }

  _historyList() {
    return _history.where((item) {
      if (_selectedTab == 'all') {
        return true;
      } else if (_selectedTab == 'integrated') {
        return item.crmContact != null;
      } else if (_selectedTab == 'coworkers') {
        return item.contact != null;
      } else if (_selectedTab == 'fusion') {
        return item.contact != null;
      } else {
        return false;
      }
    }).map((item) {
      return CallHistorySummaryView(_fusionConnection, item);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_lookedUpTab != _selectedTab) {
      lookupState = 0;
    }
    if (lookupState == 0) {
      _lookupHistory();
    }

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
                      child:
                          Text(_label.toUpperCase(), style: headerTextStyle))),
              Expanded(
                  child: CustomScrollView(slivers: [
                    SliverList(delegate: SliverChildListDelegate(_historyList()))
              ]))
            ])));
  }
}

class CallHistorySummaryView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final CallHistory _historyItem;

  CallHistorySummaryView(this._fusionConnection, this._historyItem, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallHistorySummaryViewState();
}

class _CallHistorySummaryViewState extends State<CallHistorySummaryView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  CallHistory get _historyItem => widget._historyItem;
  bool _expanded = false;

  List<Contact> _contacts() {
    if (_historyItem.contact != null) {
      return [_historyItem.contact];
    }
    else {
      return [];
    }
  }

  List<CrmContact> _crmContacts() {
    if (_historyItem.crmContact != null) {
      return [_historyItem.crmContact];
    }
    else {
      return [];
    }
  }

  _expand() {
    this.setState(() {
      _expanded = true;
    });
  }

  _name() {
    if (_historyItem.contact != null) {
      return _historyItem.contact.name;
    } else if (_historyItem.crmContact != null) {
      return _historyItem.crmContact.name;
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

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Row(children: [
          ContactCircle(_contacts(), _crmContacts()),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    _expand();
                  },
                  child: Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_name(),
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
                            child: Row(
                              children: [
                                Image.asset(_icon(), width: 12, height: 12),
                                Text(
                                " " + mDash + " " + DateFormat.jm().format(_historyItem.startTime),
                                style: TextStyle(
                                  color: _isMissed() ? crimsonLight: coal,
                                  fontSize: 12,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400))])))
                  ])))
        ]));
  }
}

class SearchContactsBar extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Function() _onClearSearch;
  final Function(String query) _onChange;

  SearchContactsBar(this._fusionConnection, this._onChange, this._onClearSearch,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchContactsBarState();
}

class _SearchContactsBarState extends State<SearchContactsBar> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  final _searchInputController = TextEditingController();

  _openMenu() {}
  String _query = "";
  int willSearch = 0;

  Function() get _onClearSearch => widget._onClearSearch;

  Function(String query) get _onChange => widget._onChange;

  _search(String val) {
    if (_searchInputController.value.text.trim() == "") {
      this._onClearSearch();
    }
    if (willSearch == 0) {
      willSearch = 1;
      Future.delayed(const Duration(seconds: 1)).then((dynamic x) {
        String query = _searchInputController.value.text;
        willSearch = 0;
        _onChange(query);
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
