import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get dateDdMMyyyy {
    return DateFormat('dd/MM/yyyy').format(this);
  }
  String get hourHHmm{
    return DateFormat('HH:mm').format(this);
  }
  String get now =>DateTime.now().dateDdMMyyyy;
  String get isToday {
    if (DateFormat('dd/MM/yyyy').format(this).compareTo(now) == 0)
      return 'Today';
    else
      return this.dateDdMMyyyy;
  }


}