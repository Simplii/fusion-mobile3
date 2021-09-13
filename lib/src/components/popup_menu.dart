import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import '../backend/fusion_connection.dart';
import '../utils.dart';
import '../styles.dart';
import 'package:intl/intl.dart';

class PopupMenu extends StatefulWidget {
  final String label;
  final Widget topChild;
  final Widget bottomChild;

  PopupMenu({this.label, this.topChild, this.bottomChild, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  String get _label => widget.label;
  Widget get _topChild => widget.topChild;
  Widget get _bottomChild => widget.bottomChild;


  Widget build(BuildContext context) {
    List<Widget> children = [
      Expanded(child: Container()),
      Container(
          padding: EdgeInsets.all(8),
          child: popupHandle())];

    if (_topChild != null) {
      children.add(_topChild);
    }

    children.add(
        Container(
            decoration: BoxDecoration(
                color: coal,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 16.5, left: 28, right: 28, bottom: 16.5),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: lightDivider,
                              width: 1.0))
                      ),
                      child: Text(
                          this._label,
                          style: TextStyle(
                              color: smoke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)
                      )),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 47.5, right: 47.5, bottom: 67.5),
                          child: _bottomChild
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: offBlack,
                            borderRadius: BorderRadius.all(Radius.circular(44)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset.fromDirection(90, 2),
                                  blurRadius: 2,
                                  spreadRadius: 0)]
                          ),
                          child: IconButton(
                              onPressed: () { Navigator.pop(context); },
                              padding: EdgeInsets.all(6),
                              icon: new Icon(CupertinoIcons.xmark, color: offWhite, size: 12)
                          )
                      )
                    ]
                  )
                ]
            )
        )
    );


    return Container(
        child: Column(
            children: [
              Expanded(child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent),
                  padding: EdgeInsets.only(top: 80, bottom: 0),
                  child: Column(children: children)
              ))
            ])
    );
  }
}