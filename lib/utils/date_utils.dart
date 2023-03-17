
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDateUtils {
  static String formatTaskDate(DateTime dateTime, BuildContext context) {
    DateFormat formatter = DateFormat(AppLocalizations.of(context)!.date_format);
    return formatter.format(dateTime);
  }
}
extension DateTimeExtension on DateTime {
  DateTime extractDateOnly() {
    //here you're inside DateTime class
    return DateTime(this.year, this.month, this.day);
  }
}