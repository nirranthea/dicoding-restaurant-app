import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {

    //Date and Time Format
    final now = DateTime.now();
    final dateformat = DateFormat('y/M/d');
    final timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    //Today format
    final todayDate = dateformat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    //Tomorrow format
    var formatted = resultToday.add(Duration(days: 1));
    final tomorrowDate = dateformat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}