import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/crm_leads_row.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/components/popup_menu.dart';
import 'package:fusion_mobile_revamped/src/models/callpop_info.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:sip_ua/sip_ua.dart';

class CallFooterDetails extends StatefulWidget {
  CallFooterDetails(this._fusionConnection, this._softphone, this._activeCall,
      {Key key})
      : super(key: key);

  final Softphone _softphone;
  final FusionConnection _fusionConnection;
  final Call _activeCall;

  @override
  State<StatefulWidget> createState() => _CallFooterDetailsState();
}

class _CallFooterDetailsState extends State<CallFooterDetails> {
  List<String> _options = [];

  void _openDispositionWindow() {
    double maxHeight = MediaQuery.of(context).size.height * 0.5;
    double contentHeight = _options.length * 60.0;
    if (contentHeight < maxHeight) maxHeight = contentHeight;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: "Call Outcomes",
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 0,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width - 136,
                    maxHeight: maxHeight),
                child: ListView(padding: EdgeInsets.all(8), children: []))));
  }

  List<List<String>> _dropdownOptions() {
    List<List<String>> options = [];
    CallpopInfo info = widget._softphone.getCallpopInfo(widget._activeCall.id);

    if (info == null)
      return options;
    else {
      List<Map<String, dynamic>> dispositionGroups = info.dispositionGroups.cast<Map<String, dynamic>>();
      for (Map<String, dynamic> group in dispositionGroups) {
        options.add([group["name"], "group"]);
        for (Map<String, dynamic> dispo in group["dispositions"]) {
          options.add(["  " + dispo["label"], dispo["id"]]);
        }
      }
      return options;
    }
  }

  _setCallOutcome(String id) {
    CallpopInfo info = widget._softphone.getCallpopInfo(widget._activeCall.id);
    List<Map<String, dynamic>> dispositionGroups = info.dispositionGroups.cast<Map<String, dynamic>>();

    for (Map<String, dynamic> group in dispositionGroups) {
      for (Map<String, dynamic> dispo in group["dispositions"]) {
        if (dispo["id"] == id) {
          widget._fusionConnection
              .apiV1Call("post", "/clients/set_callpop_disposition", {
            "call_id": widget._activeCall.id,
            "disposition": dispo,
            "disposition_id": dispo["id"],
            "leads": [],
            "phone_number":
                widget._softphone.getCallerNumber(widget._activeCall),
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CallpopInfo info = widget._softphone.getCallpopInfo(widget._activeCall.id);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
      alignment: Alignment.center,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        if (!widget._softphone.isConnected(widget._activeCall)) Spacer(),
        Container(
            height: 38,
            constraints: BoxConstraints(
                minWidth: 120,
                maxWidth: MediaQuery.of(context).size.width - 160),
            child: ListView(scrollDirection: Axis.horizontal, children: [
              CrmLeadsRow(widget._softphone, info != null ? info.crmContacts : [])
            ])),
        Spacer(),
        if (widget._softphone.isConnected(widget._activeCall))
          FusionDropdown(
              options: _dropdownOptions(),
              label: "Set Call Disposition",
              onChange: _setCallOutcome,
              button: Container(
                  decoration: BoxDecoration(
                      color: ash,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: Text('Call Outcome',
                      style: TextStyle(
                          color: coal,
                          fontSize: 12,
                          height: 1.4,
                          fontWeight: FontWeight.w700))))
      ]),
    );
  }
}
