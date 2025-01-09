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

  factory EnvironmentalData.fromJson(Map<String, dynamic> json) {
    return EnvironmentalData(
      id: json['id'] as String?,
      date: json['date'] as String?,
      humidity: json['humidity'] as num?,
      light: json['light'] as num?,
      soilMoisture: json['soilMoisture'] as num?,
      co2: json['co2'] as num?,
      rain: json['rain'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'humidity': humidity,
      'light': light,
      'soilMoisture': soilMoisture,
      'co2': co2,
      'rain': rain,
    };
  }

  @override
  String toString() {
    return 'EnvironmentalData(id: $id, date: $date, humidity: $humidity, light: $light, soilMoisture: $soilMoisture, co2: $co2, rain: $rain)';
  }
}

class StatisticData {
  StatisticData({
    required this.date,
    required this.data,
  });

  final String date;
  final double data;

  @override
  String toString() {
    return 'StatisticData(date: $date, data: $data)';
  }

  factory StatisticData.fromJson(Map<String, dynamic> json) {
    return StatisticData(
      date: json['date'] as String,
      data: json['data'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'data': data,
    };
  }
}
