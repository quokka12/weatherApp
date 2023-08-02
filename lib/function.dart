import 'package:intl/intl.dart';

String cutStringTemp(String temp) {
  int index = temp.lastIndexOf('.');
  if (index != -1) {
    return temp.substring(0, index);
  } else {
    return temp;
  }
}

String utcToHour(int utcTime) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000);
  DateFormat formatter = DateFormat('HH');
  return formatter.format(date);
}

String utcToMMDD(int utcTime) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000);
  DateFormat formatter = DateFormat('MM/DD');
  return formatter.format(date);
}
