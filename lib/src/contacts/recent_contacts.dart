import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/calls/recent_calls.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/contacts/edit_contact_view.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/utils.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../backend/fusion_connection.dart';
import '../models/phone_contact.dart';
import '../styles.dart';
import 'contact_profile_view.dart';

class RecentContactsTab extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  RecentContactsTab(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecentContactsTabState();
}

class _RecentContactsTabState extends State<RecentContactsTab> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;
  SMSConversation openConversation = null;
  bool _showingResults = false;
  String _selectedTab = 'coworkers';
  String _query = '';
  bool v2Domain = false;
  
  @override initState(){ 
    super.initState(); 
    v2Domain = _fusionConnection.settings.isV2User();
  }

  _getTitle() {
    return {
      'coworkers': 'Coworker Recents',
      'integrated': 'Integrated Recents',
      'fusion': 'Recent Contacts'
    }[_selectedTab];
  }

  _tabIcon(String name, String icon, double width, double height, {IconData iconData}) {
    return Expanded(
        child: GestureDetector(
            onTapUp: (e) {},
            onTapDown: (e) {},
            onTap: () {
              this.setState(() {
                _selectedTab = name;
              });
            },
            child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: iconData != null 
                        ? Icon(
                          iconData, 
                          color: _selectedTab == name ? Colors.white : smoke,) 
                        : Image.asset(
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
          //_tabIcon("all", "all", 23, 20.5),
          _tabIcon("coworkers", "briefcase", 23, 20.5),
          !v2Domain ? _tabIcon("integrated", "integrated", 23, 20.5) : null,
          _tabIcon("fusion", "personalcontact", 23, 20.5),
          _tabIcon(
            "addressBook", 
            "Phone Contacts", 
            23, 
            20.5, 
            iconData: _selectedTab == "addressBook" 
              ? Icons.contact_phone 
              : Icons.contact_phone_outlined
          ),
        ].where((child) => child != null).toList().cast()));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    //if (openConversation == null) {
    children = [
      SearchContactsBar(_fusionConnection, (String query) {
        this.setState(() {
          _query = query;
        });
      }, () {}),
      _tabBar(),
      ContactsSearchList(_fusionConnection, _softphone, _query, _selectedTab, v2Domain)
    ];
    return Container(child: Column(children: children));
  }
}

class ContactsSearchList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final String _query;
  final String selectedTab;
  final Function(Contact contact, CrmContact crmContact) onSelect;
  final bool isV2Domain;
  final bool fromDialpad;
  bool embedded = false;

  ContactsSearchList(
      this._fusionConnection, 
      this._softphone, 
      this._query, 
      this.selectedTab, 
      this.isV2Domain, 
      {Key key, this.embedded, this.onSelect, this.fromDialpad = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactsSearchListState();
}

class _ContactsSearchListState extends State<ContactsSearchList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  Softphone get _softphone => widget._softphone;

  bool get _embedded => widget.embedded == null ? false : widget.embedded;
  bool get _fromDialpad => widget.fromDialpad;

  String get _query => widget._query;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<Contact> _contacts = [];
  String _lookedUpQuery;
  bool get _isV2Domain => widget.isV2Domain;
  String get _selectedTab => widget.selectedTab;
  String _typeFilter = "Fusion Contacts";
  String _subscriptionKey;
  int _page = 0;
  bool _hasPulledFromServer = false;

  initState() {
    super.initState();
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
    if (lookupState == 1) return;
    lookupState = 1;
    _lookedUpQuery = _typeFilter + _query;
    String thisLookup = _typeFilter + _query;

    if (_typeFilter == 'Fusion Contacts') {
      if (_page == -1) return;
      if(_isV2Domain){
        _fusionConnection.contacts.searchV2(_query, 100, _page * 100, _fromDialpad,
          (List<Contact> contacts, bool fromServer) {
          if (thisLookup != _lookedUpQuery) return;
          if (!mounted) return;
          if (_typeFilter != 'Fusion Contacts') return;
          if (fromServer && !_hasPulledFromServer) {
            _hasPulledFromServer = true;
            _contacts = [];
            print("gotfirstcontactsfromserver");
          }

          this.setState(() {
            if (fromServer) {
              lookupState = 2;
            }
            if (_page == 0) {
              _contacts = contacts;
            } else {
              Map<String, Contact> list = {};

              _contacts.forEach((Contact c) {
                list[c.id] = c;
              });
              contacts.forEach((Contact c) {
                list[c.id] = c;
              });
              _contacts = list.values.toList().cast<Contact>();
            }
            if (_contacts.length < 100 && fromServer) {
              _page = -1;
            }
            _sortList(_contacts);
          });
        });
      } else {
        _fusionConnection.contacts.search(_query, 100, _page * 100,
          (List<Contact> contacts, bool fromServer) {
          if (thisLookup != _lookedUpQuery) return;
          if (!mounted) return;
          if (_typeFilter != 'Fusion Contacts') return;
          if (fromServer && !_hasPulledFromServer) {
            _hasPulledFromServer = true;
            _contacts = [];
            print("gotfirstcontactsfromserver");
            print(contacts);
          }

          this.setState(() {
            if (fromServer) {
              lookupState = 2;
            }
            if (_page == 0) {
              _contacts = contacts;
            } else {
              Map<String, Contact> list = {};

              _contacts.forEach((Contact c) {
                list[c.id] = c;
              });
              contacts.forEach((Contact c) {
                list[c.id] = c;
              });
              _contacts = list.values.toList().cast<Contact>();
            }
            if (_contacts.length < 100 && fromServer) {
              _page = -1;
            }
            _sortList(_contacts);
          });
        });
      }
    } else if (_typeFilter == 'Integrated Contacts') {
      if (_page == -1) return;
      _fusionConnection.integratedContacts.search(_query, 100, _page * 100,
          (List<Contact> contacts, bool fromServer, bool hasMore) {
        if (thisLookup != _lookedUpQuery) return;
        if (!mounted) return;
        if (_typeFilter != 'Integrated Contacts') return;
        if (fromServer && !_hasPulledFromServer) {
          _hasPulledFromServer = true;
          _contacts = [];
          print("gotfirstcontactsfromserver");
          print(contacts);
        }

        this.setState(() {
          if (fromServer) {
            lookupState = 2;
          }
          if (_page == 0) {
            _contacts = contacts;
          } else {
            Map<String, Contact> list = {};
            _contacts.forEach((Contact c) {
              list[c.id] = c;
            });
            contacts.forEach((Contact c) {
              list[c.id] = c;
            });
            _contacts = list.values.toList().cast<Contact>();
          }

          if (hasMore == false) {
            _page = -1;
          }

          _sortList(_contacts);
        });
      });
    } else if (_typeFilter == 'Coworkers') {
      _fusionConnection.coworkers.search(_query, (List<Contact> contacts) {
        if (thisLookup != _lookedUpQuery) return;
        if (!mounted) return;
        if (_typeFilter != 'Coworkers') return;

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
          if (!mounted || _typeFilter != 'Coworkers') return;

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
    } else if (_typeFilter == "Phone Contacts"){
        if (thisLookup != _lookedUpQuery) return;
        if (!mounted) return;
        if (!mounted || _typeFilter != 'Phone Contacts') return;
        _checkContactsPermission().then((PermissionStatus status) {
          if(status.isGranted){
            _fusionConnection.phoneContacts.getAdderssBookContacts(_query).then((List<PhoneContact> contacts){
              setState(() {
                if(contacts.isEmpty && _fusionConnection.phoneContacts.syncing){
                  print("MDBM syncing contacts");
                } else {
                  _contacts = [];
                  Map<String, Contact> list = {};
                  _contacts.forEach((Contact c) {
                    list[c.id] = c;
                  });
                  contacts.forEach((PhoneContact c) {
                    list[c.id] = c.toContact();
                  });
                  _contacts = list.values.toList().cast<Contact>();
                  _sortList(_contacts); 
                }
              });  
            });
          }
        });
    }
  }
  
  Future<PermissionStatus> _checkContactsPermission() async {
    final PermissionStatus status = await Permission.contacts.status;
    try {
      if (status.isDenied || status.isPermanentlyDenied) {
        await Permission.contacts.request();
        setState(() {  
          lookupState = 0;
        });
      }
    } catch (e) {
      print('e ${e.toString()}');
    }
    return status;
  }

  _openProfile(Contact contact) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) =>
            ContactProfileView(_fusionConnection, _softphone, contact,null)
    ).whenComplete((){
      setState(() {
        
      });
    });
  }
  
  _addContact() {
    Contact contact = Contact.fake("");
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 50
        ),
        isScrollControlled: true,
        builder: (context) =>
            EditContactView(_fusionConnection, contact, () => Navigator.pop(context, true),(){
              //oncreate
            })
    ).whenComplete((){
      setState(() {
        
      });
    });
  }

  _resultRow(String letter, Contact contact) {
    return GestureDetector(
        onTap: () {
          if (widget.onSelect != null)
            widget.onSelect(contact, null);
          else
            _openProfile(contact);
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            padding: EdgeInsets.symmetric(vertical:4 ,horizontal: 8),
            child: Row(
              children: [
                if(!_fromDialpad)
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
                      child: Container(
                        color: contact.coworker == null && contact.firstNumber() != null 
                          ?  Color.fromARGB(255, 243, 242, 242)
                          : null,
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: [
                            if(contact.coworker == null && contact.firstNumber() != null)
                              Image.asset("assets/icons/phone_filled_dark.png", width: 10, height: 10),
                            Text(
                              contact.coworker != null
                                  ? (contact.coworker.statusMessage != null
                                      ? contact.coworker.statusMessage
                                      : '')
                                  : contact.firstNumber() != null 
                                    ? contact.firstNumber().toString().formatPhone() 
                                    : "",
                              style: TextStyle(
                                  color: coal,
                                  fontSize: 12,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400)
                            ),
                          ]
                        ),
                      ))
                ]))
              ],
            )));
  }

  _sortList(List<Contact> list) {
    _contacts.sort((a, b) {
      if (_typeFilter == 'Integrated Contacts' || 
        _typeFilter == 'Phone Contacts')
        return (a.name)
            .trim()
            .toLowerCase()
            .compareTo((b.name).trim().toLowerCase());

      else
        return (a.lastName + " " + a.firstName)
            .trim()
            .toLowerCase()
            .compareTo((b.lastName + " " + b.firstName).trim().toLowerCase());
    });
  }

  // _searchList() {
  //   String usingLetter = '';
  //   List<Widget> rows = [];
  //   _contacts.forEach((item) {
  //     String letter = (item.firstName + item.lastName).trim()[0].toLowerCase();
  //     if (usingLetter != letter) {
  //       usingLetter = letter;
  //     } else {
  //       letter = "";
  //     }
  //     rows.add(_resultRow(letter, item));
  //   });
  //   return rows;
  // }

  _letterFor(Contact item) {
    if (_typeFilter == 'Integrated Contacts') {
      if (item.name.trim().length == 0)
        return " ";
      else
        return (item.name).trim()[0].toLowerCase();
    } else if (_typeFilter == 'Fusion Contacts') {
      if ((item.lastName + item.firstName).trim().length == 0)
        return " ";
      else
        return (item.lastName + item.firstName).trim()[0].toLowerCase();
    } else {
      if ((item.firstName + item.lastName).trim().length == 0)
        return " ";
      else
        return (item.firstName + item.lastName).trim()[0].toLowerCase();
    }
  }

  _spinner() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 24, top: 24, left: 48, right: 48),
        child: Center(child: SpinKitThreeBounce(color: smoke, size: 50)));
  }

  _isSpinning() {
    return lookupState < 2 &&
        _contacts.length == 0 &&
        (_typeFilter != 'Coworkers' ||
            _fusionConnection.coworkers.hasntLoaded());
  }

  @override
  Widget build(BuildContext context) {
    String origType = _typeFilter;
    if (_selectedTab == 'coworkers')
      _typeFilter = 'Coworkers';
    else if (_selectedTab == 'all')
      _typeFilter = 'Fusion Contacts';
    else if (_selectedTab == 'integrated')
      _typeFilter = 'Integrated Contacts';
    else if (_selectedTab == 'fusion')
      _typeFilter = 'Fusion Contacts';
    else if(_selectedTab == 'addressBook')
      _typeFilter = 'Phone Contacts';
    if (_typeFilter != origType) {
      _contacts = [];
    }

    if (_lookedUpQuery != _typeFilter + _query) {
      _page = 0;
      lookupState = 0;
      _hasPulledFromServer = false;
    }
    if (lookupState == 0) {
      _lookupQuery();
    }

    if(_fromDialpad){
      return Container(
        decoration: BoxDecoration(
          color:Colors.white,
        ),
        child: _contacts.length == 0 
        ? Center(
          child: _isSpinning() 
            ?  _spinner() 
            : Text("No Match Was Found"),
          )
        : Column(
          children: [
            Expanded(
              child: _isSpinning()
                ? _spinner()
                : ListView.builder(
                    itemCount: _page == -1
                        ? _contacts.length
                        : _contacts.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= _contacts.length) {
                        _loadMore();

                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: SizedBox(
                              width: 20, 
                              height: 20, 
                              child:  _typeFilter != "Coworkers" 
                                ? CircularProgressIndicator(
                                    color: crimsonDark, 
                                  )
                                : null
                            ),
                          ),
                        );
                      } else {
                        return _resultRow("", _contacts[index]);
                      }
                    },
                    padding: _fromDialpad 
                      ? null 
                      : EdgeInsets.only(left: 12, right: 12, top: _embedded ? 28 : 40)
                  )
              ),
          ],
        ),
      );
    } 

    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: _embedded ? Colors.transparent : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
            child: Stack(children: [
              Container(
                  child: _isSpinning()
                      ? _spinner()
                      : ListView.builder(
                          itemCount: _page == -1
                              ? _contacts.length
                              : _contacts.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if(_contacts.length == 0)
                              return Container(height: 20);
                            if (index >= _contacts.length) {
                              _loadMore();
                              return Container(height: 20);
                            } else {
                              String letter = _letterFor(_contacts[index]);
                              if (index != 0 &&
                                  _letterFor(_contacts[index - 1]) == letter) {
                                letter = "";
                              }
                              return _resultRow(letter, _contacts[index]);
                            }
                          },
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: _embedded ? 28 : 40))),
              Container(
                  decoration: BoxDecoration(
                    boxShadow: [],
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.5,
                          1.0
                        ],
                        colors: [
                          _embedded ? particle : Colors.white,
                          _embedded
                              ? particle.withAlpha(0)
                              : translucentWhite(0.0)
                        ]),
                  ),
                                    width: MediaQuery.of(context).size.width,

                  padding: EdgeInsets.only(
                      left: 12, top: _embedded ? 0 : 12, bottom: 32),
                  child: Text(
                      _typeFilter,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: coal))),
                if(_selectedTab == "fusion")
                Positioned(
                  bottom: 17,
                  right: 17,
                  child: FloatingActionButton(
                    backgroundColor: crimsonLight,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.add),
                    onPressed: _addContact)
                ),
              ]
            )
        )
      );
  }
}

class ContactsList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final String _label;
  final String _selectedTab;
  final Function(Contact contact, CrmContact crmContact) onSelect;

  ContactsList(
      this._fusionConnection, this._softphone, this._label, this._selectedTab,
      {Key key, this.onSelect})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  String get _label => widget._label;

  String get _selectedTab => widget._selectedTab;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<CallHistory> _history = [];
  String _lookedUpTab;
  String _subscriptionKey;
  Map<String, Coworker> _coworkers = {};
  String _expandedId = "";

  expand(item) {
    setState(() {
      if (_expandedId == item.id)
        _expandedId = "";
      else
        _expandedId = item.id;
    });
  }

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
          if (!mounted) return;

      this.setState(() {
        for (Coworker c in coworkers) {
          _coworkers[c.uid] = c;
        }
      });
    });

    _fusionConnection.callHistory.getRecentHistory(100, 0, false,
        (List<CallHistory> history, bool fromServer, bool presisted) {
          if (!mounted) return;

      this.setState(() {
        if (fromServer) {
          lookupState = 2;
        }
        List<CallHistory> historyList = [];
        var otherList = {};
        for (var item in history) {
          String number = item.getOtherNumber(_fusionConnection.getDomain());
          if (otherList[number] != true) {
            otherList[number] = true;
            historyList.add(item);
          }
        }
        _history = historyList;
      });
    });
  }

  _historyList() {
    List<Widget> response = [Container(height: 50)];
    response.addAll(_history.where((item) {
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
      return CallHistorySummaryView(_fusionConnection, _softphone, item,
          expanded: _expandedId == item.id,
          onExpand: () {
            if (widget.onSelect == null)
              expand(item);
          },
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
              Container(
                  child:Column(
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
              )),
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
                  width: MediaQuery.of(context).size.width,

                  padding: EdgeInsets.only(
                    bottom: 24,
                    top: 12,
                    left: 16,
                  ),
                  child: Text(_label.toUpperCase(), style: headerTextStyle)),
            ])));
  }
}
/*
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
          child: horizontalLine(0),
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
}*/

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
