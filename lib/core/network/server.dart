class Server {
  static const String baseUrl = "http://103.216.117.115:3001/api/v1";
}

class API {
  static const String login = "${Server.baseUrl}/auth/login";
  static const String register = "${Server.baseUrl}/auth/register";
  static const String loginWithGoogle = "${Server.baseUrl}/auth/login-google";
  static const String updateUser = "${Server.baseUrl}/users";
  static const String updatePassord = "${Server.baseUrl}/users/change-password";

  static const String updatePassword = "${Server.baseUrl}/auth/change-password";

  static const String deleteAccount = "${Server.baseUrl}/users";

  // field
  static const String createNewField = "${Server.baseUrl}/fields/create";
  static const String getFieldsByUserId = "${Server.baseUrl}/fields/user/";
  static const String getFieldById = "${Server.baseUrl}/fields/";
  static const String updateFieldById = "${Server.baseUrl}/fields/";
  static const String deleteFieldById = "${Server.baseUrl}/fields/";

  // weather
  static const String getWeatherByCity = "${Server.baseUrl}/weather/city/";

  // analysis
  static String getDailyDataRequest(
      {required String type, required String date, required String fieldId}) {
    return "${Server.baseUrl}/sensor/statistics/daily?type=$type&date=$date&fieldId=$fieldId";
  }

  static String getWeeklyDataRequest(
      {required String type, required String date, required String fieldId}) {
    return "${Server.baseUrl}/sensor/statistics/weekly?type=$type&date=$date&fieldId=$fieldId";
  }

  // water history
  static const String addWaterHistoryByFieldId =
      "${Server.baseUrl}/watering-history/";
  static const String getWaterHistoryByFieldId =
      "${Server.baseUrl}/watering-history/field/";
  static const String clearAllWaterHistoryByFieldId =
      "${Server.baseUrl}/watering-history/field/";
}
