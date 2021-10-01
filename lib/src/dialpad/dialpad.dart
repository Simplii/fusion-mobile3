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
        constraints: BoxConstraints.tightFor(height: dialedNumber == '' ? 430 - 66.0 : 430),
        decoration: BoxDecoration(color: darkGrey),
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (dialedNumber != '') Container(
              height: 66,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(left: 40)),
                  Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(dialedNumber,
                          style: TextStyle(fontSize: 36, color: Colors.white))),
                  TextButton(
                      onPressed: removeLastDigit,
                      child: Icon(CupertinoIcons.delete_left_fill))
                ],
              ),
            ),
            Container(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 350, height: 275),
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
                RawMaterialButton(
                  onPressed: placeCall,
                  elevation: 2.0,
                  fillColor: successGreen,
                  child: Icon(
                    CupertinoIcons.phone_solid,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            )
          ],
        ));
  }
}
