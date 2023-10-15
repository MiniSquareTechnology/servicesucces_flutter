extension ConvertDaysToHours on String {
  String getHoursFromDays() {
    return "${24 * int.parse(this)}";
  }

  String getDaysFromHours() {
    return "${ int.parse(this) / 24}";
  }
}