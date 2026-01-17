
Map<String,String> getNormalizedDateTimeString(DateTime date) {

  String hour = date.hour < 10 ? "0${date.hour.toString()}" : date.hour.toString();
  String min = date.minute < 10 ? "0${date.minute.toString()}" : date.minute.toString();
  String day = date.day < 10 ? "0${date.day.toString()}" : date.day.toString();
  String month = date.month < 10 ? "0${date.month.toString()}" : date.month.toString();
  
  return {
    "date": "$day.$month.${date.year.toString()}",
    "time": "$hour:$min"
  };
}

DateTime parseDateTimeString(String time, String date) {

  List<String> datenumbers = date.split(".");
  String rearrangedDate = "${datenumbers[2]}-${datenumbers[1]}-${datenumbers[0]}";

  return DateTime.parse('$rearrangedDate $time:00Z');
}