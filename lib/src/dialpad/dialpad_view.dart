import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/dialpad/contacts_search.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad.dart';
import 'package:fusion_mobile_revamped/src/dialpad/parked_calls.dart';
import 'package:fusion_mobile_revamped/src/dialpad/voicemails.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';

class DialPadView extends StatefulWidget {
  DialPadView(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _DialPadViewState();
}

class _DialPadViewState extends State<DialPadView>
    with TickerProviderStateMixin {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;
  TabController _tc;
  final int _initialIndex = 1;
  int _tabIndex = 1;

  @override
  void initState() {
    super.initState();
    _tc =
        new TabController(length: 3, initialIndex: _initialIndex, vsync: this);
    _tc.addListener(_updateTabIndex);
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _tc.animateTo(index);
  }

  void _updateTabIndex() {
    setState(() {
      _tabIndex = _tc.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: TabBarView(
        controller: _tc,
        children: [
          Container(
            constraints: BoxConstraints.tightFor(height: 725),
            child: ParkedCalls(_fusionConnection, _softphone),
          ),
          Container(
            constraints: BoxConstraints.tightFor(height: 725),
            child: Column(children: [
              Expanded(child: ContactsSearch(_fusionConnection, _softphone)),
              DialPad(_fusionConnection, _softphone)
            ]),
          ),
          Container(
            constraints: BoxConstraints.tightFor(height: 725),
            child: Voicemails(_fusionConnection, _softphone),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                    child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                            color: _tabIndex == 0
                                ? crimsonLight
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            )))),
                Expanded(
                    child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                            color: _tabIndex == 1
                                ? crimsonLight
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            )))),
                Expanded(
                    child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                            color: _tabIndex == 2
                                ? crimsonLight
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            ))))
              ]),
              BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: crimsonLight,
                unselectedItemColor: smoke,
                onTap: _onTabTapped,
                currentIndex: _tc != null ? _tc.index : 1,
                iconSize: 20,
                selectedLabelStyle: TextStyle(
                    height: 1.8, fontSize: 10, fontWeight: FontWeight.w800),
                unselectedLabelStyle: TextStyle(
                    height: 1.8, fontSize: 10, fontWeight: FontWeight.w800),
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(CupertinoIcons.car_detailed),
                    activeIcon: new Icon(CupertinoIcons.car_detailed),
                    label: "Parked Calls",
                  ),
                  BottomNavigationBarItem(
                      icon: new Icon(Icons.dialpad),
                      activeIcon: new Icon(Icons.dialpad),
                      label: 'Dial Pad'),
                  BottomNavigationBarItem(
                      icon: new Icon(CupertinoIcons.envelope_badge_fill),
                      activeIcon: new Icon(CupertinoIcons.envelope_badge_fill),
                      label: 'Voicemails')
                ],
              )
            ],
          )),
    ));
  }
}
