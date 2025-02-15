import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:green_fairm/core/network/server.dart';
import 'package:green_fairm/data/model/water_history.dart';

class WaterHistoryRepository {
  Future<List<WaterHistory>> fetchWaterHistoryByFieldId(String fieldId) async {
    try {
      var client = HttpClient();
      var request = await client
          .postUrl(Uri.parse('${API.getWaterHistoryByFieldId}$fieldId'));
      request.headers.set('content-type', 'application/json');
      var response = await request.close();
      if (response.statusCode != 201) {
        throw Exception(
            'Failed to get water history from server. Response code: ${response.statusCode}');
      } else {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['statusCode'] != 201) {
          throw Exception(
              'Failed to get water history from server. Status code: ${jsonResponse['statusCode']}');
        } else {
          var waterHistoryList = (jsonResponse['metadata']['data'] as List)
              .map((data) => WaterHistory.fromJson(data))
              .toList();
          for (var waterHistory in waterHistoryList) {
            if (kDebugMode) {
              print(waterHistory);
            }
          }
          return waterHistoryList;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching water history: $e');
      }
      rethrow;
    }
  }

  Future<void> clearAllWaterHistoryByFieldId(String fieldId) async {
    try {
      var client = HttpClient();
      var request = await client
          .patchUrl(Uri.parse('${API.clearAllWaterHistoryByFieldId}$fieldId'));
      request.headers.set('content-type', 'application/json');
      var response = await request.close();
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to clear all water history from server. Response code: ${response.statusCode}');
      } else {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['statusCode'] != 200) {
          throw Exception(
              'Failed to clear all water history from server. Status code: ${jsonResponse['statusCode']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing all water history: $e');
      }
      rethrow;
    }
  }

  Future<void> addWaterHistory(WaterHistory waterHistory) async {
    try {
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(API.addWaterHistoryByFieldId));
      request.headers.set('content-type', 'application/json');
      var requestBody = {
        "startDate": waterHistory.startDate,
        "endDate": waterHistory.endDate,
        "fieldId": waterHistory.fieldId
      };
      request.add(utf8.encode(jsonEncode(requestBody)));
      var response = await request.close();
      if (response.statusCode != 201) {
        throw Exception(
            'Failed to add water history to server. Response code: ${response.statusCode}');
      } else {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['statusCode'] != 201) {
          throw Exception(
              'Failed to add water history to server. Status code: ${jsonResponse['statusCode']}');
        } else {
          if (kDebugMode) {
            print(jsonEncode(jsonResponse));
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding water history: $e');
      }
      rethrow;
    }
  }
}
