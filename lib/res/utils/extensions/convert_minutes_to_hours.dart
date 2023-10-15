
extension ConvertHoursToMinutes on Duration {
  String get getHoursAndMinutes {
    final hh = (this.inHours).toString().padLeft(2, '0');
    final mm = (this.inMinutes % 60).toString().padLeft(2, '0');
    return "$hh:$mm";
  }
}