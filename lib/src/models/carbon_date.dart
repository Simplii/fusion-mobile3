import 'dart:convert' as convert;

class CarbonDate {
  String date;
  String timezone;
  int timezone_type;

  serialize() {
    return convert.jsonEncode({
      'date': date,
      'timezone': timezone,
      'timezone_type': timezone_type
    });
  }

  CarbonDate.unserialize(String data) {
    Map<String, dynamic> obj = convert.jsonDecode(data);
    this.date = obj['date'];
    this.timezone = obj['timezone'];
    this.timezone_type = obj['timezone_type'];
  }

  CarbonDate(Map<String, dynamic> obj) {
    this.date = obj['date'];
    this.timezone = obj['timezone'];
    this.timezone_type = obj['timezone_type'];
  }
}
