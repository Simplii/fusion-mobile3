
class CarbonDate {
  String date;
  String timezone;
  int timezone_type;

  CarbonDate(Map<String, dynamic> obj) {
    this.date = obj['date'];
    this.timezone = obj['timezone'];
    this.timezone_type = obj['timezone_type'];
  }
}
