import 'package:green_fairm/data/model/environmental_data.dart';

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

  static String getTodayDateFormatted() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static double calculateAverage(List<num?> values) {
    final nonNullValues =
        values.whereType<num>().map((value) => value.toDouble()).toList();
    if (nonNullValues.isEmpty) return 0.0;
    final average =
        nonNullValues.reduce((a, b) => a + b) / nonNullValues.length;
    return double.parse(average.toStringAsFixed(1));
  }

  static double calculateAverageGround(List<num?> values) {
    final nonNullValues =
        values.whereType<num>().map((value) => value.toDouble()).toList();
    if (nonNullValues.isEmpty) return 0.0;
    return nonNullValues.reduce((a, b) => a + b) / nonNullValues.length;
  }

  static double getMinimumData(List<StatisticData> dataList) {
    if (dataList.isEmpty) {
      throw ArgumentError('The dataList cannot be empty');
    }
    double minData =
        dataList.map((e) => e.data).reduce((a, b) => a < b ? a : b);
    return minData > 100
        ? Helper.scaleToPercentageNum(minData.toInt(), 0, 4095)
        : minData;
  }

  static double getMaximumData(List<StatisticData> dataList) {
    if (dataList.isEmpty) {
      throw ArgumentError('The dataList cannot be empty');
    }
    double maxData =
        dataList.map((e) => e.data).reduce((a, b) => a > b ? a : b);
    return maxData > 100
        ? Helper.scaleToPercentageNum(maxData.toInt(), 0, 4095)
        : maxData;
  }

  static List<StatisticData> scaleStatisticDataList(
      List<StatisticData> dataList, int min, int max) {
    return dataList.map((stat) {
      double scaledData =
          Helper.scaleToPercentageNum(stat.data.toInt(), min, max);
      return StatisticData(date: stat.date, data: scaledData);
    }).toList();
  }

  static String getFirstDateOfLastWeek() {
    final now = DateTime.now();
    final lastMonday = now.subtract(Duration(days: now.weekday + 6));
    final year = lastMonday.year;
    final month = lastMonday.month.toString().padLeft(2, '0');
    final day = lastMonday.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String getFirstDateOfLastTwoWeeks() {
    final now = DateTime.now();
    final lastTwoWeeksMonday = now.subtract(Duration(days: now.weekday + 13));
    final year = lastTwoWeeksMonday.year;
    final month = lastTwoWeeksMonday.month.toString().padLeft(2, '0');
    final day = lastTwoWeeksMonday.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static int getNumberOfDaysInWeek() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    return lastDayOfWeek.difference(firstDayOfWeek).inDays + 1;
  }

  static List<String> getPassedDaysOfCurrentWeek() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final today = DateTime(now.year, now.month, now.day);

    return List.generate(now.weekday, (index) {
      final currentDate = firstDayOfWeek.add(Duration(days: index));
      final year = currentDate.year;
      final month = currentDate.month.toString().padLeft(2, '0');
      final day = currentDate.day.toString().padLeft(2, '0');
      return '$year-$month-$day';
    });
  }

  static String getFormattedDay(DateTime date) {
    final now = DateTime.now();
    final dayName = _getDayName(date.weekday);
    final day = date.day;
    final month = _getMonthName(date.month);
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return 'Today, $day $month';
    }
    return '$dayName, $day $month';
  }

  static String _getDayName(int weekday) {
    const dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return dayNames[weekday - 1];
  }
}
