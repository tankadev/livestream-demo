import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static DateTime? stringToDateTime(String? date) {
    return date != null ? DateTime.parse(date) : null;
  }

  static String dateTimeToISOString(DateTime date) {
    return date.toIso8601String();
  }

  static String formatDateWithString({
    required DateTime? inputDate,
    required String format,
    BuildContext? context,
  }) {
    if (inputDate == null) {
      return '';
    }
    if (context != null) {
      String locale = Localizations.localeOf(context).languageCode;
      return DateFormat(format, locale).format(inputDate);
    }
    return DateFormat(format).format(inputDate);
  }
}
