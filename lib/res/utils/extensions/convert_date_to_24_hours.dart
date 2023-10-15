import 'package:intl/intl.dart';

extension ConvertDateTo24Hours on DateTime {
  String get24HourFromDate() {
    return DateFormat().add_Hm().format(this);
  }
}
