import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';

import '../styles.dart';
import 'dialpad_key.dart';

class DialPad extends StatefulWidget {
  DialPad(this._fusionConnection, this._softphone, {Key key}) : super(key: key);

  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  var dialedNumber = '';

  void handleDialPadKeyPress(String key) {
    setState(() {
      dialedNumber += key;
    });

    print('DialPad key pressed : $key');
  }

  void removeLastDigit() {
    if (dialedNumber.length == 0) return;

    setState(() {
      dialedNumber = dialedNumber.substring(0, dialedNumber.length - 1);
    });
  }

  void placeCall() {
    _softphone.makeCall(dialedNumber);
    Navigator.pop(context);
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
    return Container(
        decoration: BoxDecoration(
            color: darkGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            )),
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (dialedNumber != '')
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 0, bottom: 10),
                width: MediaQuery.of(context).size.width - 24,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                        height: 40,
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width - 24,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width - 24,
                                  child: Text(dialedNumber,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 36, color: Colors.white)))
                            ])),
                    GestureDetector(
                        onTap: removeLastDigit,
                        child: Opacity(
                            opacity: 0.66,
                            child: Container(
                                decoration: clearBg(),
                                height: 22,
                                width: 40,
                                child: Container(
                                    width: 22,
                                    height: 16,
                                    child: Image.asset(
                                        "assets/icons/call_view/backspace.png",
                                        width: 22,
                                        height: 16)))))
                  ],
                ),
              ),
            if (dialedNumber != '')
              Container(
                  height: 1,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(color: translucentWhite(0.1494))),
            if (dialedNumber == '')
              Container(height: 6),
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
                GestureDetector(
                  onTap: placeCall,
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
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                            color: successGreen,
                          ),
                          child: Image.asset(
                              "assets/icons/call_view/phone_answer.png",
                              width: 24,
                              height: 24))),
                ),
              ],
            )
          ],
        ));
  }
}
