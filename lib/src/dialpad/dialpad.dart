import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';
import 'dialpadKey.dart';

class DialPad extends StatefulWidget {
  DialPad({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
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

  void placeCall() {}

  var digits = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'];
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
    '',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: darkGrey),
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(left: 40)),
                Padding(
                    padding: EdgeInsets.fromLTRB(18, 12, 0, 0),
                    child: Text(dialedNumber,
                        style: TextStyle(fontSize: 36, color: Colors.white))),
                TextButton(
                    onPressed: removeLastDigit,
                    child: Icon(CupertinoIcons.delete_left_fill))
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: digits
                  .map((digit) => DialPadKey(
                      onPressed: () {
                        handleDialPadKeyPress(digit);
                      },
                      digit: digit))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: placeCall,
                  elevation: 2.0,
                  fillColor: Colors.green,
                  child: Icon(
                    CupertinoIcons.phone_solid,
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
