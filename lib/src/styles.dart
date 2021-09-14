import 'package:flutter/material.dart';

Color fusionRed = Color.fromARGB(255, 255, 51, 74);
Color crimsonLight = fusionRed;
Color darkGrey = Color.fromARGB(255, 51, 45, 46);
Color coal = Color.fromARGB(255, 51, 45, 45);
Color translucentSmoke = Color.fromARGB(38, 153, 148, 149);
Color char = Color.fromARGB(255, 102, 94, 96);
Color smoke = Color.fromARGB(255, 153, 148, 149);
Color halfSmoke = Color.fromARGB(128, 153, 148, 149);
Color particle = Color.fromARGB(255, 243, 242, 242);
Color lightHighlight = Color.fromARGB(26, 255, 255, 255);
Color lightDivider = Color.fromARGB(255, 102, 94, 96);
Color offWhite = Color.fromARGB(255, 229, 227, 228);
Color offBlack = Color.fromARGB(255, 27, 24, 24);

TextStyle headerTextStyle = TextStyle(
    color: coal, fontSize: 16, fontWeight: FontWeight.w700, height: 1.4);

String mDash = "\u2014";

TextStyle subHeaderTextStyle = TextStyle(
    color: coal, fontSize: 12, height: 1.4, fontWeight: FontWeight.w400);

TextStyle smallTextStyle = subHeaderTextStyle;

TextStyle dropdownTextStyle =
    TextStyle(color: coal, fontSize: 14, fontWeight: FontWeight.w700);

BoxDecoration dropdownDecoration = BoxDecoration(
    color: translucentSmoke,
    borderRadius: BorderRadius.all(Radius.circular(4)));

horizontalLine(double margin) {
  return Expanded(
      child: Container(
          margin: EdgeInsets.only(top: margin, bottom: margin),
          decoration: BoxDecoration(
            color: halfSmoke,
          ),
          height: 1));
}

popupHandle() {
  return Container(
      decoration: BoxDecoration(
          color: halfSmoke, borderRadius: BorderRadius.all(Radius.circular(3))),
      width: 36,
      height: 5);
}
