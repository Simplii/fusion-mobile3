import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import 'contact_profile_view.dart';

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
  String _query = '';

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
                  bottomRedBar(_selectedTab != name),
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
      SearchContactsBar(_fusionConnection, (String query) {
        this.setState(() {
          if (query.trim() != "") {
            print("searching now " + query);
            _showingResults = true;
            _query = query;
          } else {
            _showingResults = false;
          }
        });
      }, () {
        this.setState(() {
          _showingResults = false;
        });
      }),
      !_showingResults ? _tabBar() : Container(),
      (_showingResults
          ? ContactsSearchList(_fusionConnection, _query, _selectedTab)
          : ContactsList(_fusionConnection, _getTitle(), _selectedTab))
    ];
    return Container(child: Column(children: children));
  }
}

class ContactsSearchList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final String _query;
  final String _defaultTab;

  ContactsSearchList(this._fusionConnection, this._query, this._defaultTab,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactsSearchListState();
}

class _ContactsSearchListState extends State<ContactsSearchList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  String get _query => widget._query;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<Contact> _contacts = [];
  String _lookedUpQuery;

  String get _defaultTab => widget._defaultTab;
  String _typeFilter = "Fusion Contacts";
  String _subscriptionKey;
  int _page = 0;

  initState() {
    super.initState();
    if (_defaultTab == 'coworkers')
      _typeFilter = 'Coworkers';
    else if (_defaultTab == 'all')
      _typeFilter = 'Fusion Contacts';
    else if (_defaultTab == 'integrated')
      _typeFilter = 'Integrated Contacts';
    else if (_defaultTab == 'fusion') _typeFilter = 'Fusion Contacts';
  }

  _subscribeCoworkers(List<String> uids, Function(List<Coworker>) callback) {
    if (_subscriptionKey != null) {
      _fusionConnection.coworkers.clearSubscription(_subscriptionKey);
    }

    _subscriptionKey = _fusionConnection.coworkers.subscribe(uids, callback);
  }

  @override
  dispose() {
    super.dispose();
    if (_subscriptionKey != null) {
      _fusionConnection.coworkers.clearSubscription(_subscriptionKey);
    }
  }

  _loadMore() {
    _page += 1;
    _lookupQuery();
  }

  _lookupQuery() {
    print("contactssearch looking up " + _query + " " + lookupState.toString() + " " + _page.toString());
    if (lookupState == 1) return;
    lookupState = 1;
    _lookedUpQuery = _query;

    if (_typeFilter == 'Fusion Contacts') {
      if (_page == -1) return;
      _fusionConnection.contacts.search(_query, 100, _page * 100,
              (List<Contact> contacts, bool fromServer) {
            print("gotresult" + contacts.toString());
            this.setState(() {
              if (fromServer) {
                lookupState = 2;
              }
              if (_page == 0) {
                _contacts = contacts;
              }
              else {
                Map<String, Contact> list = {};
                _contacts.forEach((Contact c) { list[c.id] = c; });
                contacts.forEach((Contact c) { list[c.id] = c; });
                _contacts = list.values.toList().cast<Contact>();
              }
              if (_contacts.length < 100 && fromServer) {
                _page = -1;
              }
              _sortList(_contacts);
            });
          });
    } else if (_typeFilter == 'Integrated Contacts') {
      if (_page == -1) return;
      _fusionConnection.integratedContacts.search(
          _query, 100, _page * 100,
              (List<Contact> contacts, bool fromServer) {
                print("gotresult" + contacts.toString());
                this.setState(() {
                  if (fromServer) {
                    lookupState = 2;
                  }

                  if (_page == 0) {
                    _contacts = contacts;
                  }
                  else {
                    Map<String, Contact> list = {};
                    _contacts.forEach((Contact c) { list[c.id] = c; });
                    contacts.forEach((Contact c) { list[c.id] = c; });
                    _contacts = list.values.toList().cast<Contact>();
                  }
                  if (contacts.length < 100 && fromServer) {
                    _page = -1;
                  }
                  _sortList(_contacts);
                });
              });
    } else if (_typeFilter == 'Coworkers') {
      _fusionConnection.coworkers.search(_query, (List<Contact> contacts) {
        this.setState(() {
          lookupState = 2;
          _contacts = contacts;
        });
        _subscribeCoworkers(
            contacts
                .map((Contact c) {
                  return c.coworker.uid;
                })
                .toList()
                .cast<String>(), (List<Coworker> coworkers) {
          this.setState(() {
            _contacts = coworkers
                .map((Coworker c) {
                  return c.toContact();
                })
                .toList()
                .cast<Contact>();
            _sortList(_contacts);
          });
        });
      });
    }
  }

  _openProfile(Contact contact) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            ContactProfileView(_fusionConnection, contact));
  }

  _resultRow(String letter, Contact contact) {
    return GestureDetector(
        onTap: () { _openProfile(contact); },
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Row(
              children: [
                Container(
                    width: 32,
                    height: 50,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: letter.length > 0
                            ? Text(letter.toUpperCase(),
                                style: TextStyle(
                                    color: smoke,
                                    fontSize: 16,
                                    height: 1,
                                    fontWeight: FontWeight.w500))
                            : Container())),
                ContactCircle.withDiameter([contact], [], 36),
                Expanded(
                    child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(contact.name,
                          style: TextStyle(
                              color: coal,
                              fontSize: 14,
                              fontWeight: FontWeight.w700))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          contact.coworker != null
                              ? contact.coworker.statusMessage
                              : '',
                          style: TextStyle(
                              color: smoke,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)))
                ]))
              ],
            )));
  }

  _sortList(List<Contact> list) {
    _contacts.sort((a, b) {
      return (a.firstName + a.lastName)
          .trim()
          .toLowerCase()
          .compareTo((b.firstName + b.lastName).trim().toLowerCase());
    });
  }

  _searchList() {
    String usingLetter = '';
    List<Widget> rows = [];
    _contacts.forEach((item) {
      String letter = (item.firstName + item.lastName).trim()[0].toLowerCase();
      if (usingLetter != letter) {
        usingLetter = letter;
      } else {
        letter = "";
      }
      rows.add(_resultRow(letter, item));
    });
    return rows;
  }

  _letterFor(Contact item) {
    return (item.firstName + item.lastName).trim()[0].toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    if (_lookedUpQuery != _query) {
      _page = 0;
      lookupState = 0;
    }
    if (lookupState == 0) {
      _lookupQuery();
    }

    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(left: 12, top: 12, bottom: 4),
                  child: FusionDropdown(
                      onChange: (String value) {
                        this.setState(() {
                          _typeFilter = value;
                          _page = 0;
                          lookupState = 0;
                        });
                      },
                      value: _typeFilter,
                      label: "Contact Type",
                      options: [
                        ["INTEGRATED CONTACTS", "Integrated Contacts"],
                        ["COWORKERS", "Coworkers"],
                        ["FUSION CONTACTS", "Fusion Contacts"]
                      ],
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: coal))),
              Expanded(
                  child: ListView.builder(
                      itemCount: _page == -1 ? _contacts.length : _contacts.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= _contacts.length) {
                          _loadMore();
                          return Container();
                        }
                        else {
                          String letter = _letterFor(_contacts[index]);
                          if (index != 0 && _letterFor(
                              _contacts[index - 1]) == letter) {
                            letter = "";
                          }
                          return _resultRow(letter, _contacts[index]);
                        }
                      },
                      padding: EdgeInsets.only(left: 12, right: 12)))
            ])));
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
            padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 0),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(
                    bottom: 24,
                    left: 4,
                  ),
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
    print("tappedmessage");
    String number =
        _fusionConnection.smsDepartments.getDepartment("-2").numbers[0];
    print("tapped number" + number);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(
            _fusionConnection,
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

  _openProfile() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            ContactProfileView(_fusionConnection, _historyItem.contact));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [_topPart()];

    if (_expanded) {
      children.add(Container(
          child: horizontalLine(0),
          margin: EdgeInsets.only(top: 4, bottom: 4)));
      children.add(Container(
          height: 28,
          margin: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(children: [
            actionButton("Profile", "user_dark", 18, 18, _openProfile),
            actionButton("Call", "phone_dark", 18, 18, () {}),
            actionButton("Message", "message_dark", 18, 18, _openMessage)
            // _actionButton("Video", "video_dark", 18, 18, () {}),
          ])));
    }

    return Container(
        height: _expanded ? 132 : 76,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 0),
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
  String _selectedTab;

  _openMenu() {
    Scaffold.of(context).openDrawer();
  }

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
