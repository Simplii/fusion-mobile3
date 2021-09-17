import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallFooterDetails extends StatefulWidget {
  CallFooterDetails({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallFooterDetailsState();
}

class _CallFooterDetailsState extends State<CallFooterDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
      child: Row(
        children: [Text('crms & disposition button')],
      ),
    );
  }
}
