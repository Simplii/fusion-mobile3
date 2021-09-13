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

import 'popup_menu.dart';

class FusionDropdown extends StatefulWidget {
  final List<Widget> children;
  final String label;
  final List<List<String>> options;
  final String value;
  final TextStyle style;
  final Function(String value) onChange;

  FusionDropdown({
    Key key,
    this.onChange,
    this.children,
    this.label,
    this.value,
    this.style,
    this.options}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FusionDropdownState();
}

class _FusionDropdownState extends State<FusionDropdown> {
  List<Widget> get _children => widget.children;
  String get _label => widget.label;
  TextStyle get _style => widget.style;
  List<List<String>> get _options => widget.options;
  String get _value => widget.value;
  Function(String value) get _onChange => widget.onChange;

  _openPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (contact) => PopupMenu(
        label: _label,
        bottomChild: Column(
          children: _options.map((List<String> option) {
            return GestureDetector(
                onTap: () {
                  _onChange(option[1]);
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
                    decoration: BoxDecoration(
                        color: option[1] == _value ? lightHighlight: Colors.transparent,
                        border: Border(bottom: BorderSide(
                            color: lightDivider,
                            width: 1.0))
                    ),
                    child: Text(option[0],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700))
            ));
          }).toList()
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openPopup,
      child: Row(
          children: [
            Text(this._value, style: _style != null ? _style : subHeaderTextStyle),
            IconButton(
              onPressed: _openPopup,
                padding: EdgeInsets.all(0),
                icon: Image.asset("assets/icons/down_arrow.png",
                    height: 5, width: 10)
            ),
          ])
    );
  }
}