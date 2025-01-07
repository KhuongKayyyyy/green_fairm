class Helper {
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

  static String scaleToPercentage(int value, int min, int max) {
    if (value < min || value > max) {
      throw ArgumentError('Value must be within the range [$min, $max]');
    }
    final percentage = (value - min) / (max - min) * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }

  static double scaleToPercentageNum(int value, int min, int max) {
    if (value < min || value > max) {
      throw ArgumentError('Value must be within the range [$min, $max]');
    }
    return 100 - ((value - min) / (max - min) * 100);
  }

  static String getState(String location) {
    return location.split(", ")[1];
  }

  static String getCity(String location) {
    return location.split(", ")[0];
  }

  static String getCountry(String location) {
    return location.split(", ")[2];
  }
}
