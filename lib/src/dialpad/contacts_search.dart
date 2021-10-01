import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';

class ContactsSearch extends StatefulWidget {
  ContactsSearch(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _ContactsSearchState();
}

class _ContactsSearchState extends State<ContactsSearch> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  }
}
