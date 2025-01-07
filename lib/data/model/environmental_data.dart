// / this class is used for char implementation
class EnvironmentalData {
  EnvironmentalData({
    this.id,
    this.date,
    this.humidity,
    this.light,
    this.soilMoisture,
    this.co2,
    this.rain,
  });
  final String? id;
  final String? date;
  final num? humidity;
  final num? light;
  final num? soilMoisture;
  final num? co2;
  final num? rain;
}

class TemperatureData {
  TemperatureData({
    this.id,
    this.date,
    this.temperature,
  });
  final String? id;
  final String? date;
  final num? temperature;
}
