import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles.dart';
import 'dialpad_key.dart';

class DialPad extends StatefulWidget {
  DialPad(this._fusionConnection, this._softphone,
      {Key key, this.onQueryChange, this.onPlaceCall})
      : super(key: key);

  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final Function onQueryChange;
  final Function(String number) onPlaceCall;

  @override
  State<StatefulWidget> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> with TickerProviderStateMixin {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  var dialedNumber = '';
  final _dialEntryController = ScrollController();
  bool _lastNumberCalledIsSet = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadLastCalledNumber();
  }

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    _dialEntryController.animateTo(
      _dialEntryController.position.maxScrollExtent,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _loadLastCalledNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastNumberCalledIsSet = prefs.getString('lastCalledNumber') != null ? true : false;
    });
  }

  void handleDialPadKeyPress(String key) {
    setState(() {
      dialedNumber += key;
      _controller.text = dialedNumber;
      print("MyDebugMessage ${key}");
      if (widget.onQueryChange != null) widget.onQueryChange(dialedNumber);
      Future.delayed(const Duration(milliseconds: 50), () {
        _scrollToEnd();
      });
    });
  }

  void pasteNumber() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data == null) return;
    String pastedNumber = data.text.onlyNumbers();
    if (pastedNumber.length > 10 && pastedNumber.startsWith("1", 0)) {
      pastedNumber = pastedNumber.substring(1);
    }
    setState(() {
      dialedNumber = pastedNumber;
      if (widget.onQueryChange != null) widget.onQueryChange(dialedNumber);
    });
  }

  void removeLastDigit() {
    if (dialedNumber.length == 0) return;

    setState(() {
      dialedNumber = dialedNumber.substring(0, dialedNumber.length - 1);
      if (widget.onQueryChange != null) widget.onQueryChange(dialedNumber);
    });
  }

  void placeCall() {
    if (widget.onPlaceCall != null)
      widget.onPlaceCall(dialedNumber);
    else {
      _softphone.makeCall(dialedNumber);
      Navigator.pop(context);
    }
  }

  var digitAlphas = [
    '',
    'ABC',
    'DEF',
    'GHI',
    'JKL',
    'MNO',
    'PQRS',
    'TUV',
    'WXYZ',
    '',
    '+',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: dialedNumber,
          style: TextStyle(fontSize: 32 * scaleFactor, color: Colors.white)),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    final textWidth = textPainter.size.width.ceil();
    double textSize = 36;
    if(dialedNumber.length > 10){
      textSize = 31;
    } 
    return Container(
        decoration: BoxDecoration(
            color: darkGrey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            )),
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: 69 * scaleFactor,
                child: Column(
                    key: ValueKey<String>(
                        dialedNumber == "" ? "emptykey" : "enteredkey"),
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 0, bottom: 10),
                        width: MediaQuery.of(context).size.width - 24,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: pasteNumber,
                                child: Opacity(
                                    opacity: 0.66,
                                    child: Container(
                                        decoration: clearBg(),
                                        height: 42,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 0,
                                            right: 20),
                                        width: 46,
                                        child: Container(
                                            width: 22,
                                            height: 16,
                                            child: Image.asset(
                                                "assets/icons/paste_white.png",
                                                width: 22,
                                                height: 16))))),
                            Container(
                                height:
                                    40 * MediaQuery.of(context).textScaleFactor,
                                alignment: Alignment.topCenter,
                                width: MediaQuery.of(context).size.width - 122,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    controller: _dialEntryController,
                                    children: [
                                      Container(
                                          alignment: Alignment.topCenter,
                                          width: max(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  122,
                                              textWidth.toDouble()),
                                          child: Text(dialedNumber,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: textSize,
                                                  color: Colors.white))
                                        )
                                    ])),
                            if (dialedNumber != '')
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(5)),
                                    onPressed: removeLastDigit,
                                    child: Opacity(
                                        opacity: 0.66,
                                        child: Image.asset(
                                            "assets/icons/call_view/backspace.png",
                                            width: 26,
                                            height: 22))),
                              )
                          ],
                        ),
                      ),
                      Container(
                          height: 1,
                          margin: EdgeInsets.only(bottom: 12),
                          decoration:
                              BoxDecoration(color: translucentWhite(0.1494))),
                      if (dialedNumber == '') Container(height: 4),
                    ])),
            Container(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 350),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '1',
                            alphas: digitAlphas[0]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '2',
                            alphas: digitAlphas[1]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '3',
                            alphas: digitAlphas[2]),
                      ],
                    ),
                    Row(
                      children: [
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '4',
                            alphas: digitAlphas[3]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '5',
                            alphas: digitAlphas[4]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '6',
                            alphas: digitAlphas[5]),
                      ],
                    ),
                    Row(
                      children: [
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '7',
                            alphas: digitAlphas[6]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '8',
                            alphas: digitAlphas[7]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '9',
                            alphas: digitAlphas[8]),
                      ],
                    ),
                    Row(
                      children: [
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '*',
                            alphas: digitAlphas[9]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '0',
                            alphas: digitAlphas[10]),
                        DialPadKey(
                            onPressed: handleDialPadKeyPress,
                            digit: '#',
                            alphas: digitAlphas[11]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                    opacity: (_lastNumberCalledIsSet || dialedNumber != "") ? 1.0 : 0.5,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: dialedNumber == ""
                          ? () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final String lastDialedNumber =
                                  prefs.getString('lastCalledNumber');
                              if (lastDialedNumber != null) {
                                setState(() {
                                  dialedNumber = lastDialedNumber;
                                  if (widget.onQueryChange != null)
                                    widget.onQueryChange(lastDialedNumber);
                                });
                              } else {
                                print("No number have been called yet");
                              }
                            }
                          : placeCall,
                      child: Container(
                          margin: EdgeInsets.only(top: 12, bottom: 14),
                          decoration: raisedButtonBorder(successGreen,
                              lightenAmount: 40, darkenAmount: 40),
                          padding: EdgeInsets.all(1),
                          child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(28)),
                                color: successGreen,
                              ),
                              child: Image.asset(
                                  "assets/icons/call_view/phone_answer.png",
                                  width: 24,
                                  height: 24))),
                    ))
              ],
            )
          ],
        ));
  }
}
