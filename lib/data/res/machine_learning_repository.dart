import 'dart:convert';
import 'dart:io';

import 'package:green_fairm/core/network/server.dart';
import 'package:green_fairm/data/model/environmental_data.dart';

class MachineLearningRepository {
  Future<double> getPlantHealthPrediction(
      EnvironmentalData data, double temp) async {
    try {
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(API.getPlantHeathPrediction));
      request.headers.set('content-type', 'application/json');

      var jsonMap = {
        "humidity": data.humidity,
        "temperature": temp,
        "light": data.light,
        "soilMoisture": data.soilMoisture,
        "rainVolume": data.rain,
        "gasVolume": data.co2,
      };

      request.add(utf8.encode(json.encode(jsonMap)));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        print("Health plant prediction Response: $responseBody"); // Debugging

        // Since the response is just a number, parse it directly
        return double.tryParse(responseBody) ?? -1;
      } else {
        throw HttpException('Failed to get prediction',
            uri: Uri.parse(API.getPlantHeathPrediction));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<double> getWaterNeedPrediction(
      EnvironmentalData data, double temp) async {
    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(API.getWaterNeedPrediction));
      request.headers.set('content-type', 'application/json');

      var jsonMap = {
        "humidity": data.humidity,
        "temperature": temp,
        "light": data.light,
        "soilMoisture": data.soilMoisture,
        "rainVolume": data.rain,
        "gasVolume": data.co2,
      };

      print("Water need prediction request: $jsonMap"); // Debugging

      request.add(utf8.encode(json.encode(jsonMap)));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        print("Water need response: $responseBody"); // Debugging

        // Since the response is just a number, parse it directly
        return double.tryParse(responseBody) ?? -1;
      } else {
        throw HttpException('Failed to get prediction',
            uri: Uri.parse(API.getPlantHeathPrediction));
      }
    } catch (e) {
      rethrow;
    }
  }
}
