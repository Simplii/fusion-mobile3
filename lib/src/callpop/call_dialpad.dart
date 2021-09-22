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
          child: Column(
            children: [
              Row(
                children: [
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '1', alphas: digitAlphas[0]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '2', alphas: digitAlphas[1]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '3', alphas: digitAlphas[2]),
                ],
              ),
              Row(
                children: [
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '4', alphas: digitAlphas[3]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '5', alphas: digitAlphas[4]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '6', alphas: digitAlphas[5]),
                ],
              ),
              Row(
                children: [
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '7', alphas: digitAlphas[6]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '8', alphas: digitAlphas[7]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '9', alphas: digitAlphas[8]),
                ],
              ),
              Row(
                children: [
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '*', alphas: digitAlphas[9]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '0', alphas: digitAlphas[10]),
                  DialPadKey(onPressed: handleDialPadKeyPress, digit: '#', alphas: digitAlphas[11]),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
