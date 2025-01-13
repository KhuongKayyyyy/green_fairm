import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:green_fairm/core/constant/sensor_type.dart';
import 'package:green_fairm/core/network/server.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/environmental_data.dart';

class EnvironmentalDataRepository {
  Future<List<StatisticData>> getDailyStatistic(
      {required String date,
      required String type,
      required String fieldId}) async {
    try {
      List<StatisticData> dailyStatisticData = [];
      var client = HttpClient();
      var request = await client.getUrl(Uri.parse(
          API.getDailyDataRequest(type: type, date: date, fieldId: fieldId)));
      request.headers.set('content-type', 'application/json');
      var response = await request.close();
      if (response.statusCode == 200) {
        // Parse the response body
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['metadata'] != null &&
            jsonResponse['metadata'] is List) {
          for (var item in jsonResponse['metadata']) {
            if (item['avgValue'] != null) {
              String hour;
              switch (item['unit']) {
                case 0:
                  hour = "12 AM";
                  break;
                case 1:
                  hour = "1 AM";
                  break;
                case 2:
                  hour = "2 AM";
                  break;
                case 3:
                  hour = "3 AM";
                  break;
                case 4:
                  hour = "4 AM";
                  break;
                case 5:
                  hour = "5 AM";
                  break;
                case 6:
                  hour = "6 AM";
                  break;
                case 7:
                  hour = "7 AM";
                  break;
                case 8:
                  hour = "8 AM";
                  break;
                case 9:
                  hour = "9 AM";
                  break;
                case 10:
                  hour = "10 AM";
                  break;
                case 11:
                  hour = "11 AM";
                  break;
                case 12:
                  hour = "12 PM";
                  break;
                case 13:
                  hour = "1 PM";
                  break;
                case 14:
                  hour = "2 PM";
                  break;
                case 15:
                  hour = "3 PM";
                  break;
                case 16:
                  hour = "4 PM";
                  break;
                case 17:
                  hour = "5 PM";
                  break;
                case 18:
                  hour = "6 PM";
                  break;
                case 19:
                  hour = "7 PM";
                  break;
                case 20:
                  hour = "8 PM";
                  break;
                case 21:
                  hour = "9 PM";
                  break;
                case 22:
                  hour = "10 PM";
                  break;
                case 23:
                  hour = "11 PM";
                  break;
                default:
                  hour = "Unknown";
              }
              var statisticData = StatisticData(
                  time: hour, data: item['avgValue'].toDouble(), date: date);
              // if (kDebugMode) {
              //   print('Statistic Data: $statisticData');
              // }
              dailyStatisticData.add(statisticData);
            }
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
      if (type == SensorType.humidity || type == SensorType.temperature) {
        return dailyStatisticData;
      } else {
        dailyStatisticData =
            Helper.scaleStatisticDataList(dailyStatisticData, 0, 4095);
        return dailyStatisticData;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting daily temperature analysis from server: $e');
      }
      rethrow;
    }
  }

  Future<List<StatisticData>> getWeeklyStatistic(
      {required String date,
      required String type,
      required String fieldId}) async {
    try {
      List<StatisticData> weeklyStatisticData = [];
      var client = HttpClient();
      var request = await client.getUrl(Uri.parse(
          API.getWeeklyDataRequest(type: type, date: date, fieldId: fieldId)));
      request.headers.set('content-type', 'application/json');
      var response = await request.close();
      if (response.statusCode == 200) {
        // Parse the response body
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['metadata'] != null &&
            jsonResponse['metadata'] is List) {
          for (var item in jsonResponse['metadata']) {
            if (item['avgValue'] != null) {
              String day;
              switch (item['unit']) {
                case 1:
                  day = "Mon";
                  break;
                case 2:
                  day = "Tues";
                  break;
                case 3:
                  day = "Wed";
                  break;
                case 4:
                  day = "Thurs";
                  break;
                case 5:
                  day = "Fri";
                  break;
                case 6:
                  day = "Sat";
                  break;
                case 7:
                  day = "Sun";
                  break;
                default:
                  day = "Unknown";
              }
              var statisticData = StatisticData(
                time: day,
                data: item['avgValue'].toDouble(),
                date: item['date'],
              );
              // if (kDebugMode) {
              //   print('Statistic Data: $statisticData');
              // }
              weeklyStatisticData.add(statisticData);
            }
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }

      if (type == SensorType.humidity || type == SensorType.temperature) {
        return weeklyStatisticData;
      } else {
        weeklyStatisticData =
            Helper.scaleStatisticDataList(weeklyStatisticData, 0, 4095);
        return weeklyStatisticData;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting daily temperature analysis from server: $e');
      }
      rethrow;
    }
  }
}
