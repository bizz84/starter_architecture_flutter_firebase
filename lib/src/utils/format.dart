import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

class Format {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String formatForTable(DateTime datetime) =>
      '${DateFormat.Md(PlatformDispatcher.instance.locale.toStringWithSeparator()).format(datetime)} ${DateFormat.jm(PlatformDispatcher.instance.locale.toStringWithSeparator()).format(datetime)}';

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }

  static String formatForSchedule(String time) => DateFormat("h a").format(DateFormat("HH:mm:ss").parse(time));
}
