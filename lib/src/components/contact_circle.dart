import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';

class ContactCircle extends StatefulWidget {
  final List<Contact> _contacts;
  final List<CrmContact> _crmContacts;
  double _diameter = 60;

  ContactCircle(this._contacts, this._crmContacts, {Key key}) : super(key: key);
  ContactCircle.withDiameter(this._contacts, this._crmContacts, this._diameter, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactCircleState();
}

class _ContactCircleState extends State<ContactCircle> {
  List<Contact> get _contacts => widget._contacts;
  List<CrmContact> get _crmContacts => widget._crmContacts;
  double get _diameter => widget._diameter;

  _gravatarUrl(String email) {
    print(email);
    return Gravatar(email).imageUrl();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = null;
    if (_contacts != null) {
      for (Contact contact in _contacts) {
        if (contact.emails != null) {
          for (Map<String, dynamic> email in contact.emails) {
            try {
              imageUrl = _gravatarUrl(email['email']);
            } catch (e) {}
          }
        }
      }
    }
    if (_crmContacts != null) {
      for (CrmContact contact in _crmContacts) {
        if (contact.emails != null) {
          for (String email in contact.emails) {
            try {
              imageUrl = _gravatarUrl(email);
            } catch (e) {}
          }
        }
      }
    }

    Widget contactImage = ClipRRect(
      borderRadius: BorderRadius.circular((_diameter - 4) / 2),
      child: (imageUrl != null
        ? Image.network(imageUrl, height: _diameter - 4, width: _diameter - 4)
        : Image.asset(
          "assets/blank_avatar.png",
          height: _diameter - 4,
          width: _diameter - 4)));

    Color borderColor = Colors.red;

    return Container(
      margin: EdgeInsets.only(right: _diameter / 3),
      decoration: BoxDecoration(
              border: Border.all(
                  color: borderColor,
                  width:2),
              borderRadius: BorderRadius.all(Radius.circular(_diameter / 2))),
      width: _diameter,
      height: _diameter,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white,
                  width:2),
              borderRadius: BorderRadius.all(Radius.circular((_diameter - 4) / 2))),
          width: _diameter - 4,
          height: _diameter - 4,
          child: contactImage
      )
    );
  }
}
