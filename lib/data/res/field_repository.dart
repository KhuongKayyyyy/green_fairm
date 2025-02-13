import 'dart:convert'; // Import for jsonEncode
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:green_fairm/core/network/server.dart';
import 'package:green_fairm/data/model/field.dart';

class FieldRepository {
  Future<void> saveNewFieldToServer({
    required String name,
    required String area,
    required String userId,
  }) async {
    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(API.createNewField));
      request.headers.set('content-type', 'application/json');

      final body = jsonEncode({
        "name": name,
        "area": area,
        "userId": userId,
      });

      request.write(body);

      var response = await request.close();

      if (response.statusCode != 201) {
        throw Exception(
            'Failed to save farm to server. Response code: ${response.statusCode}');
      } else {
        if (kDebugMode) {
          print('Farm saved to server successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving farm to server: $e');
      }
      rethrow;
    }
  }

  Future<List<Field>> getFieldsByUserId(String userId) async {
    try {
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse('${API.getFieldsByUserId}$userId'));
      request.headers.set('content-type', 'application/json');
      var response = await request.close();

      if (response.statusCode != 201) {
        throw Exception(
            'Failed to get fields from server. Response code: ${response.statusCode}');
      } else {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['statusCode'] != 201) {
          throw Exception(
              'Failed to get fields from server. Status code: ${jsonResponse['statusCode']}');
        }

        // Extract the "data" array from the "metadata" field
        var fields = jsonResponse['metadata']['data'] as List;

        // Map the JSON objects to Field objects
        return fields.map((field) => Field.fromJson(field)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting fields from server: $e');
      }
      rethrow;
    }
  }

  Future<void> updateField(Field field) async {
    try {
      var client = HttpClient();
      var request =
          await client.patchUrl(Uri.parse('${API.updateFieldById}${field.id}'));
      request.headers.set('content-type', 'application/json');

      // if (kDebugMode) {
      //   print('Updating field with id: ${field.id}');
      // }
      // if (kDebugMode) {
      //   print(request.uri);
      // }
      final body = jsonEncode({
        "name": field.name,
        "area": field.area,
      });

      request.write(body);

      var response = await request.close();

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update farm to server. Response code: ${response.statusCode}');
      } else {
        if (kDebugMode) {
          print('Farm updated to server successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating farm to server: $e');
      }
      rethrow;
    }
  }

  Future<void> deleteField(Field field) async {
    try {
      var client = HttpClient();
      var request = await client
          .deleteUrl(Uri.parse('${API.deleteFieldById}${field.id}'));
      request.headers.set('content-type', 'application/json');

      var response = await request.close();

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to delete farm from server. Response code: ${response.statusCode}');
      } else {
        if (kDebugMode) {
          print('Farm deleted from server successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting farm from server: $e');
      }
      rethrow;
    }
  }

  Future<Field> getFieldById(String fieldId) async {
    try {
      var client = HttpClient();
      var request =
          await client.getUrl(Uri.parse('${API.getFieldById}$fieldId'));
      var response = await request.close();

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to get field from server. Response code: ${response.statusCode}');
      } else {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['statusCode'] != 200) {
          throw Exception(
              'Failed to get field from server. Status code: ${jsonResponse['statusCode']}');
        }

        var field = jsonResponse['metadata'];

        return Field.fromJson(field);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting field from server: $e');
      }
      rethrow;
    }
  }

  Future<void> updateFieldSetting(Field field, String settingType) async {
    try {
      var client = HttpClient();
      var request = await client
          .patchUrl(Uri.parse('${API.getFieldById}${field.id}/$settingType'));
      request.headers.set('content-type', 'application/json');

      var response = await request.close();

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update field setting to server. Response code: ${response.statusCode}');
      } else {
        if (kDebugMode) {
          print('Field setting updated to server successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating field setting to server: $e');
      }
      rethrow;
    }
  }
}
