import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';

import '../styles.dart';

class ContactCircle extends StatefulWidget {
  final List<Contact> _contacts;
  final List<CrmContact> _crmContacts;
  Coworker _coworker;
  double _diameter = 60;
  double _margin = null;

  ContactCircle(this._contacts, this._crmContacts, {Key key}) : super(key: key);
  ContactCircle.withCoworker(this._contacts, this._crmContacts, this._coworker,
      {Key key}) : super(key: key);

  ContactCircle.withCoworkerAndDiameter(this._contacts, this._crmContacts, this._coworker, this._diameter,
      {Key key}) : super(key: key);

  ContactCircle.withDiameter(this._contacts, this._crmContacts, this._diameter,
      {Key key})
      : super(key: key);

  ContactCircle.withDiameterAndMargin(
      this._contacts, this._crmContacts, this._diameter, this._margin,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactCircleState();
}

class _ContactCircleState extends State<ContactCircle> {
  List<Contact> get _contacts => widget._contacts;
  List<CrmContact> get _crmContacts => widget._crmContacts;
  Coworker get _coworker => widget._coworker;
  double get _diameter => widget._diameter;
  double get _margin => widget._margin;

  _gravatarUrl(String email) {
    return Gravatar(email).imageUrl();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = null;
    Coworker coworker = _coworker;

    if (_contacts != null) {
      for (Contact contact in _contacts) {
        if (contact.coworker != null && coworker == null) {
          coworker = contact.coworker;
        }
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

    String presence = null;
    if (coworker != null) {
      imageUrl = coworker.url;
      presence = coworker.presence;
    }

    Widget contactImage = ClipRRect(
        borderRadius: BorderRadius.circular((_diameter - 4) / 2),
        child: Container(
            width: _diameter - 4,
            height: _diameter - 4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: (imageUrl != null
                      ? NetworkImage(imageUrl)
                      : AssetImage("assets/blank_avatar.png"))))));


    Color borderColor = Colors.transparent;
    if (presence == "open") borderColor = Color.fromARGB(255, 0, 204, 136);
    else if (presence == 'inactive') borderColor = smoke;
    else if (presence == 'ringing'
        || presence == 'alerting'
        || presence == 'progressing') borderColor = informationBlue;
    else if (presence == 'inuse'
        || presence == 'held') borderColor = crimsonLight;

    return Container(
        margin: EdgeInsets.only(
            right: this._margin != null ? this._margin : _diameter / 3),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(_diameter / 2))),
        width: _diameter,
        height: _diameter,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 2),
                borderRadius:
                    BorderRadius.all(Radius.circular((_diameter - 4) / 2))),
            width: _diameter - 4,
            height: _diameter - 4,
            child: contactImage));
  }
}
