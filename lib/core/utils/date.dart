
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