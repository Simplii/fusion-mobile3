import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/dialpad/dialpad_key.dart';

class CallDialPad extends StatefulWidget {
  CallDialPad({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallDialPadState();
}

class _CallDialPadState extends State<CallDialPad> {
  var dialedNumber = '';

  void handleDialPadKeyPress(String key) {
    setState(() {
      dialedNumber += key;
    });

    print('In-call DialPad key pressed : $key');
  }

  void removeLastDigit() {
    if (dialedNumber.length == 0) return;

    setState(() {
      dialedNumber = dialedNumber.substring(0, dialedNumber.length - 1);
    });
  }

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
    '+',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: 350),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: digits
                .asMap()
                .map((index, digit) => MapEntry(
                    index,
                    DialPadKey(
                      onPressed: () {
                        handleDialPadKeyPress(digit);
                      },
                      digit: digit,
                      alphas: digitAlphas[index],
                    )))
                .values
                .toList(),
          ),
        )
      ],
    ));
  }
}
