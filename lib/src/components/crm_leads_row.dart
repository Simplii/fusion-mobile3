import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles.dart';

class CrmLeadsRow extends StatefulWidget {
  CrmLeadsRow(this._softphone, this._activeCall, {Key key}) : super(key: key);

  final Softphone _softphone;
  final Call _activeCall;


  @override
  State<StatefulWidget> createState() => _CrmLeadsRowState();
}

class _CrmLeadsRowState extends State<CrmLeadsRow> {
  @override
  Widget build(BuildContext context) {
    CallpopInfo info = widget._softphone.getCallpopInfo(widget._activeCall.id);
    return Container(
      child: Row(
        children:
          info.crmContacts.map((CrmContact c) {

            return GestureDetector(
                onTap: () { launch(c.url); },
                child: Container(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            c.icon,
                            height: 22, width: 22),
                          Container(height: 6),
                          Text((c.module.substring(c.module.length - 1) == "s"
                              ? c.module.substring(0, c.module.length - 1)
                              : c.module).toUpperCase(),
                              style: TextStyle(
                                  fontSize: 8,
                                  color: smoke,
                                  fontWeight: FontWeight.w900))
                        ]
                    )
            ));
          }).toList().cast<Widget>(),

      ),
    );
  }
}
