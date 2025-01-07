import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:green_fairm/core/network/server.dart';
import 'package:green_fairm/data/model/weather_model.dart';

class WeatherReposity {
  static Future<WeatherModel> fetchWeather(String cityName) async {
    var client = HttpClient();
    var request =
        await client.getUrl(Uri.parse("${API.getWeatherByCity}$cityName"));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    var response = await request.close();
    if (response.statusCode == 200) {
      var jsonString = await response.transform(utf8.decoder).join();
      var jsonMap = jsonDecode(jsonString);
      WeatherModel weather = WeatherModel.fromJson(jsonMap);
      if (kDebugMode) {
        print('Weather: $weather');
      }
      return weather;
    } else {
      if (kDebugMode) {
        print('Failed getting weather');
      }
      throw const HttpException('Failed getting weather');
    }
  }
}
