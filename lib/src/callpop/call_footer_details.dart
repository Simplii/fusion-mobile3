import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/crm_leads_row.dart';
import 'package:fusion_mobile_revamped/src/components/popup_menu.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';
import 'package:sip_ua/sip_ua.dart';

class CallFooterDetails extends StatefulWidget {
  CallFooterDetails(this._softphone, this._activeCall, {Key key}) : super(key: key);

  final Softphone _softphone;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!widget._softphone.isConnected(widget._activeCall))
            Spacer(),
          CrmLeadsRow(widget._softphone, widget._activeCall),
          Spacer(),
          if (widget._softphone.isConnected(widget._activeCall))
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: ash,
                padding: EdgeInsets.only(left: 16, right: 16)),
              onPressed: _openDispositionWindow,

              child: Text(
                  'Call Outcome',
                  style: TextStyle(
                      color: coal,
                      fontSize: 12,
                      height: 1.4,
                      fontWeight: FontWeight.w700)))
        ],
      ),
    );
  }
}
