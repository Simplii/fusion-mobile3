import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';
import 'popup_menu.dart';

class FusionDropdown extends StatefulWidget {
  final List<Widget> children;
  final String label;
  final List<List<String>> options;
  final String value;
  final TextStyle style;
  final Function(String value) onChange;
  final Widget button;

  FusionDropdown(
      {Key key,
      this.onChange,
      this.button,
      this.children,
      this.label,
      this.value,
      this.style,
      this.options})
      : super(key: key);

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

  Widget get _button => widget.button;

  _openPopup() {
    double maxHeight = MediaQuery.of(context).size.height * 0.5;
    double contentHeight = _options.length * 60.0;
    if (contentHeight < maxHeight) maxHeight = contentHeight;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: _label,
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 24,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width - 136,
                    maxHeight: maxHeight),
                child: ListView(
                    padding: EdgeInsets.all(8),
                    children: _options.map((List<String> option) {
                      return GestureDetector(
                          onTap: () {
                            _onChange(option[1]);
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 18, right: 18),
                              decoration: BoxDecoration(
                                  color: option[1] == _value
                                      ? lightHighlight
                                      : Colors.transparent,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightDivider, width: 1.0))),
                              child: Text(option[0],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))));
                    }).toList()))));
  }

  @override
  Widget build(BuildContext context) {
    String selected = this._value;
    for (List<String> opt in _options) {
      if (opt[1] == this._value) {
        selected = opt[0];
      }
    }

    return GestureDetector(
        onTap: _openPopup,
        child: this._button != null
            ? this._button
            : Row(children: [
                Text(selected,
                    style: _style != null ? _style : subHeaderTextStyle),
                IconButton(
                    onPressed: _openPopup,
                    padding: EdgeInsets.all(0),
                    icon: Image.asset("assets/icons/down_arrow.png",
                        height: 5, width: 10)),
              ]));
  }
}
