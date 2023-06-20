import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/utils.dart';

import '../styles.dart';

class DialpadRecentCalls extends StatefulWidget {
  final Contact contact;
  final Softphone softphone;
  const DialpadRecentCalls({
    Key key,
    @required this.contact, 
    @required this.softphone
  }) : super(key: key);

  @override
  State<DialpadRecentCalls> createState() => _DialpadRecentCallsState();
}

class _DialpadRecentCallsState extends State<DialpadRecentCalls> {
  Contact get _contact => widget.contact;
  Softphone get _softphone => widget.softphone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ 
        _softphone.makeCall(_contact.firstNumber());
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:4 ,horizontal: 8),
        child: Row(
          children: [
            ContactCircle.withDiameter([_contact], [], 36),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _contact?.name ?? "Unknown", 
                  style: TextStyle(
                    color: coal,
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  _contact.firstNumber().toString().formatPhone(),
                  style: TextStyle(
                    color: smoke,
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}