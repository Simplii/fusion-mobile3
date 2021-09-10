import 'dart:convert';
import 'dart:math';

extension PhoneNumbers on String {
  String formatPhone() {
    return '(' + this.substring(0, 3) + ") "
        + this.substring(3, 6) + "-"
        + this.substring(6, 10);
  }
}

 randomString(int len) {
   var random = Random.secure();
   var values = List<int>.generate(len, (i) =>  random.nextInt(255));
   return base64UrlEncode(values);
}