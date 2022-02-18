import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';

uuidFromString(String str) {
  if (str.length == 0)
    return Uuid().v4();

  else {
    List<int> numbers = [];
    int strIndex = 0;

    for (var i = 0; i < 16; i++) {
      if (strIndex > str.length)
        strIndex = 0;

      numbers.add(str.codeUnitAt(strIndex));
      strIndex += 1;
    }

    return Uuid().v4(options: {'random': numbers});
  }
}

intIdForString(String str) {
  if (str == null)
    return 0;

  else {
    int id = 1;
    for (var i = 0; i < str.length; i++) {
      id += i * 256 + str.codeUnitAt(i);
    }
    return id;
  }
}

extension durations on int {
  String printDuration() {
    String duration = "";

    int seconds = this % 60;
    int minutes = (this / 60).floor();
    int hours = (this / (60 * 60)).floor();

    if (hours > 0) {
      return hours.toString() + ":"
          + (minutes < 10 ? "0" : "") + minutes.toString() + ":"
          + (seconds < 10 ? "0" : "") + seconds.toString();
    } else {
        return (minutes < 10 ? "0" : "") + minutes.toString() + ":"
          + (seconds < 10 ? "0" : "") + seconds.toString();
    }
  }
}

extension PhoneNumbers on String {
  String formatPhone() {
    if (this.contains("@"))
      return this;
    else if (this.length < 10)
      return this;
    else
      return '(' +
          this.substring(0, 3) +
          ") " +
          this.substring(3, 6) +
          "-" +
          this.substring(6, 10);
  }

  String onlyNumbers() {
    return this.replaceAll(RegExp(r'[^0-9]+'), '');
  }
}

randomString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
