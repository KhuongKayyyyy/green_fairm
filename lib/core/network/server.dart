class Server {
  static const String baseUrl = "http://103.216.117.115:3001/api/v1";
}

class API {
  static const String login = "${Server.baseUrl}/auth/login";
  static const String register = "${Server.baseUrl}/auth/register";
  static const String loginWithGoogle = "${Server.baseUrl}/auth/login-google";
  static const String createNewField = "${Server.baseUrl}/fields/create";

  // field
  static const String getFieldsByUserId = "${Server.baseUrl}/fields/user/";
  static const String updateFieldById = "${Server.baseUrl}/fields/";
  static const String deleteFieldById = "${Server.baseUrl}/fields/";

  // weather
  static const String getWeatherByCity = "${Server.baseUrl}/weather/city/";
}
