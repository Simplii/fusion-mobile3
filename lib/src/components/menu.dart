import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/messages/sms_conversation_view.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:fusion_mobile_revamped/src/models/user_settings.dart';
import 'package:intl/intl.dart';

import '../backend/fusion_connection.dart';
import '../styles.dart';
import '../utils.dart';

class Menu extends StatefulWidget {
  final FusionConnection _fusionConnection;

  Menu(this._fusionConnection, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  FusionConnection get _fusionConnection => widget._fusionConnection;


  _header() {
    UserSettings settings = _fusionConnection.settings;
    var callid = settings.subscriber.containsKey('callid_nmbr')
        ? settings.subscriber['callid_nmbr']
        : '';
    var user = settings.subscriber.containsKey('user')
        ? settings.subscriber['user']
        : '';
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: bgBlend),
      padding: EdgeInsets.only(top: 72, left: 18, bottom: 12, right: 18),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: ContactCircle.withCoworkerAndDiameter(
                  [settings.myContact()],
                  [],
                  _fusionConnection.coworkers.lookupCoworker(_fusionConnection.getUid()),
                  70)),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 18, bottom: 6),
            child: Text(
              settings.myContact().name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700
              )
            )
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 0, bottom: 12),
            child: Text(
                ("" + callid ).formatPhone()
                  + " " + mDash + " x" + user,
                style: TextStyle(
                    color: translucentWhite(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w500
              )
            )
          )
        ]
      )
    );
  }


  _row(String icon, String label, String smallText, Function onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
      decoration: BoxDecoration(color: Colors.transparent),
      margin: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(right: 24),
              width: 22, height: 22,
              child: Image.asset(
                  "assets/icons/" + icon + ".png",
                  width: 22, height: 22)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Container(height: 4),
              Text(
                  smallText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: smoke,
                      fontSize: 12,
                      fontWeight: FontWeight.w400))
            ]
          )
        ]
      ))
    );
  }

  _line() {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: 24),
              width: 20, height: 20),
          horizontalLine(12)]));
   }

  _body() {
    List<Widget> response =  [
      _row("gear_light", "Settings", "Coming soon", () {}),
      _line(),
      _row("moon_light", "Log Out", "", () { _fusionConnection.logOut(); })
    ];
    return response;
  }

  @override
  Widget build(BuildContext context) {
    bool isFusionPlus = _fusionConnection.settings.hasFusionPlus();
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fill.jpg"),
              fit: BoxFit.cover),
            color: bgBlend),
        child: Column(
          children: [
            _header(),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(color: coal),
                    child: ListView(children: _body())
                )
            ),
            Container(
                decoration: BoxDecoration(color: coal),
                padding: EdgeInsets.only(left: 18, right: 18, bottom: 24, top: 12),
                child: Row(
                  children: [
                    Image.asset("assets/simplii_logo.png", width: 125, height: 18),
                    Expanded(child: Container()),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(color: halfSmoke, width: 1.0)
                        ),
                        child: Text(
                            isFusionPlus ? "Fusion Plus" : "Fusion",
                            style: TextStyle(
                                color: halfSmoke,
                                fontStyle: FontStyle.italic,
                                fontSize: 11,
                                fontWeight: FontWeight.w700))
                    )
                  ]
                )
            )
          ]
        )
      )
    );
  }
}
