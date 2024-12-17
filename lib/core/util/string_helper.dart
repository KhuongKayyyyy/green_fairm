class StringHelper {
  static String getFormattedDate() {
    final now = DateTime.now();
    final day = now.day;
    final month = _getMonthName(now.month);
    return '$day $month';
  }

  static String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  static String getFormattedDateWithShortMonth({int offsetDays = 0}) {
    final now = DateTime.now().add(Duration(days: offsetDays));
    final day = now.day;
    final month = _getShortMonthName(now.month);
    return '$month, $day';
  }

  static String _getShortMonthName(int month) {
    const shortMonthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return shortMonthNames[month - 1];
  }
}
