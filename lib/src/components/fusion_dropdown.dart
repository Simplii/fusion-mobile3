import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:fusion_mobile_revamped/src/utils.dart';

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
  List<SMSDepartment> departments;
  final String selectedNumber;
  final Function(String value) onNumberTap;

  FusionDropdown(
      {Key key,
      this.onChange,
      this.button,
      this.children,
      this.label,
      this.value,
      this.style,
      this.options,
      this.departments,
      this.selectedNumber,
      this.onNumberTap})
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

  List<SMSDepartment> get _allDepartments => widget.departments;

  String get _selectedNumber => widget.selectedNumber;

  Function(String value) get _onNumberTap => widget.onNumberTap;

  _dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _bottomSheetOption(List option) {
    if (_allDepartments != null) {
      List<String> deptNUmbers = [];

      _allDepartments.forEach((element) {
        if (element.id == option[1]) {
          deptNUmbers = element.numbers;
        }
      });

      return Container(
        decoration: BoxDecoration(
            color: option[1] == _value ? lightHighlight : Colors.transparent,
            border:
                Border(bottom: BorderSide(color: lightDivider, width: 1.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _onChange(option[1]);
                  Navigator.pop(context);
                },
                child: Row(children: [
                  Container(
                    width: 220,
                    padding: EdgeInsets.only(
                        bottom:10,
                        top: 14,
                        left: 12),
                    child: Text(
                      option[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ]),
              ),
              Column(
                  children: deptNUmbers.map((String option) {
                    return Container(
                      decoration: BoxDecoration(
                        // color: _selectedNumber == option
                        //     ? lightHighlight
                        //     : Colors.transparent,
                      ),
                      padding: EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          left: 12,
                          right: _selectedNumber == option ? 12 : 0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _onNumberTap(option);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              option.formatPhone(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: _selectedNumber == option
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: _selectedNumber == option
                                      ? FontWeight.w700
                                      : FontWeight.normal),
                            ),
                            Spacer(),
                            Visibility(
                              child: Image.asset("assets/icons/check_white.png",
                                  height: 17, width: 17),
                              visible: _selectedNumber == option ? true : false,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList())
            ],
          ),
      );
    } else {
      return Container(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
          decoration: BoxDecoration(
              color: option[1] == _value ? lightHighlight : Colors.transparent,
              border:
                  Border(bottom: BorderSide(color: lightDivider, width: 1.0))),
          child: GestureDetector(
            onTap: () {
              _onChange(option[1]);
              Navigator.pop(context);
            },
            child: Text(option[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ));
    }
  }

  _openPopup() {
    double maxHeight = MediaQuery.of(context).size.height * 0.5;
    double contentHeight = _options.length * 60.0;
    if (contentHeight > 0 && contentHeight < maxHeight)
      maxHeight = contentHeight;

    _dismissKeyboard();

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
                      return Container(child: _bottomSheetOption(option));
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
        behavior: HitTestBehavior.translucent,
        onTap: _openPopup,
        child: this._button != null
            ? this._button
            : Row(children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth:  MediaQuery.of(context).size.width - 250,),
                  child: Text(selected,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: _style != null ? _style : subHeaderTextStyle,
                  ),
                ),
                Container(
                  child: Text(" " + mDash + " " + _selectedNumber.formatPhone()),
                ),
                Container(
                    margin: EdgeInsets.only(left: 3, right: 12),
                    width: 10,
                    height: 5,
                    child: Image.asset("assets/icons/down_arrow.png",
                        height: 5, width: 10)),
              ]));
  }
}
