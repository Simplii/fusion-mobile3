import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/dialpad/contacts_search.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad.dart';

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
    return Container(
      constraints: BoxConstraints.tightFor(height: 725),
      child: Column(children: [
        Expanded(child: ContactsSearch(_fusionConnection, _softphone)),
        DialPad(_fusionConnection, _softphone)
      ]),
    );
  }
}
