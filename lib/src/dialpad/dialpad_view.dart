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

  Widget body() {
    return Container(
        child: TabBarView(
      controller: _tc,
      children: [
        Container(
          child: ParkedCalls(_fusionConnection, _softphone),
        ),
        Container(
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
    ));
  }

  Widget navBar() {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            color: particle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8))),
        padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
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
              selectedItemColor: crimsonDarker,
              unselectedItemColor: coal,
              onTap: _onTabTapped,
              currentIndex: _tc != null ? _tc.index : 1,
              iconSize: 20,
              selectedLabelStyle: TextStyle(
                  color: crimsonDarker,
                  height: 2, fontSize: 10, fontWeight: FontWeight.w700),
              unselectedLabelStyle: TextStyle(
                  color: coal,
                  height: 2, fontSize: 10, fontWeight: FontWeight.w700),
              items: [
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/call_view/toolbar/park_inactive.png", width: 13.6, height: 20),
                  activeIcon: Image.asset("assets/icons/call_view/toolbar/park_active.png", width: 13.6, height: 20),

                  label: "Parked Calls",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/call_view/toolbar/dialpad_inactive.png", width: 17.45, height: 20),
                    activeIcon: Image.asset("assets/icons/call_view/toolbar/dialpad_active.png", width: 17.45, height: 20),
                    label: 'Dial Pad'),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/call_view/toolbar/voicemail_inactive.png", width: 22, height: 20),
                  activeIcon: Image.asset("assets/icons/call_view/toolbar/voicemail_active.png", width: 22, height: 20),
                    label: 'Voicemails')
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(children: [
                        Expanded(
                            child: body()),
                        Container(
                            decoration: BoxDecoration(color: coal),
                            child: navBar())]),
                      Container(
                          alignment: Alignment.topCenter,
                          height: 8,
                          width: 80,
                          margin: EdgeInsets.all(8),
                          child: Center(child: popupHandle()))
                    ]))));
  }
}
