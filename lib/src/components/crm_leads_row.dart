import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrmLeadsRow extends StatefulWidget {
  CrmLeadsRow({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CrmLeadsRowState();
}

class _CrmLeadsRowState extends State<CrmLeadsRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Image.asset("assets/crm_icons/hubspot.png",
                  height: 16, width: 16)),
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Image.asset("assets/crm_icons/helpscout.png",
                  height: 16, width: 16))
        ],
      ),
    );
  }
}
