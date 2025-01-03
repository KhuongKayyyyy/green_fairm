class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String humidity;
  final double windSpeed;
  final String weatherIcon;
  final String visibility;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.weatherIcon,
    required this.visibility,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'];
    final weather = metadata['weather'][0];
    final main = metadata['main'];
    final wind = metadata['wind'];

    return WeatherModel(
      cityName: metadata['name'],
      temperature: main['temp'] - 273.15,
      description: weather['description'],
      humidity: main['humidity'].toString(),
      windSpeed: wind['speed'],
      weatherIcon: weather['icon'],
      visibility: metadata['visibility'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'description': description,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'weatherIcon': weatherIcon,
      'visibility': visibility,
    };
  }

  @override
  String toString() {
    return 'WeatherModel(cityName: $cityName, temperature: $temperature, description: $description, humidity: $humidity, windSpeed: $windSpeed, weatherIcon: $weatherIcon, visibility: $visibility)';
  }
}
