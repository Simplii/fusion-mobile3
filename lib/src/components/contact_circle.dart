import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';

class ContactCircle extends StatefulWidget {
  final List<Contact> _contacts;
  final List<CrmContact> _crmContacts;

  ContactCircle(this._contacts, this._crmContacts, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactCircleState();
}

class _ContactCircleState extends State<ContactCircle> {
  List<Contact> get _contacts => widget._contacts;

  List<CrmContact> get _crmContacts => widget._crmContacts;

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
        borderRadius: BorderRadius.circular(27),
        child: (imageUrl != null
            ? Image.network(imageUrl, height: 56, width: 56)
            : Image.asset("assets/blank_avatar.png", height: 56, width: 56)));

    Color borderColor = Colors.red;
    print("contact stuff " + contactImage.toString());
    return Container(
        margin: EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        width: 60,
        height: 60,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(27))),
            width: 56,
            height: 56,
            child: contactImage));
  }
}
