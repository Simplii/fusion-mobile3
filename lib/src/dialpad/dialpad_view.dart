import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/dialpad/contacts_search.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';

class DialPadView extends StatefulWidget {
  DialPadView(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _DialPadViewState();
}

class _DialPadViewState extends State<DialPadView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: TabBarView(
        children: [
          Container(
            constraints: BoxConstraints.tightFor(height: 725),
            color: Colors.yellow,
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
            color: Colors.lightGreen,
          )
        ],
      ),
      bottomNavigationBar: new TabBar(
        tabs: [
          Tab(
            icon: new Icon(CupertinoIcons.car_detailed),
            text: 'Parked',
          ),
          Tab(
            icon: new Icon(Icons.dialpad),
            text: 'Dial Pad'
          ),
          Tab(
            icon: new Icon(CupertinoIcons.envelope_badge_fill),
            text: 'Voicemail'
          ),
        ],
        labelColor: smoke,
        unselectedLabelColor: ash,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.red,
      ),
    ));
  }
}
