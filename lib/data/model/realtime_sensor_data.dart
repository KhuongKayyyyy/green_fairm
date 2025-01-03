class RealtimeSensorData {
  String id;
  String humidity;
  String temperature;
  String light;
  String soilMoisture;
  String rainVolume;
  String gasVolume;
  String fieldId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RealtimeSensorData({
    required this.id,
    required this.humidity,
    required this.temperature,
    required this.light,
    required this.soilMoisture,
    required this.rainVolume,
    required this.gasVolume,
    required this.fieldId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RealtimeSensorData.fromJson(Map<String, dynamic> json) {
    return RealtimeSensorData(
      id: json['_id'] ?? '', // Default to an empty string if null
      humidity: json['humidity'] ?? '0.0', // Default to '0.0' if null
      temperature: json['temperature'] ?? '0.0', // Default to '0.0' if null
      light: json['light'] ?? '0.0', // Default to '0.0' if null
      soilMoisture: json['soilMoisture'] ?? '0.0', // Default to '0.0' if null
      rainVolume: json['rainVolume'] ?? '0.0', // Default to '0.0' if null
      gasVolume: json['gasVolume'] ?? '0.0', // Default to '0.0' if null
      fieldId: json['fieldId'] ?? '', // Default to an empty string if null
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // Default to current time if null
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(), // Default to current time if null
      v: json['__v'] ?? 0, // Default to 0 if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'humidity': humidity,
      'temperature': temperature,
      'light': light,
      'soilMoisture': soilMoisture,
      'rainVolume': rainVolume,
      'gasVolume': gasVolume,
      'fieldId': fieldId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  @override
  String toString() {
    return 'SensorData{id: $id, humidity: $humidity, temperature: $temperature, light: $light, soilMoisture: $soilMoisture, rainVolume: $rainVolume, gasVolume: $gasVolume, fieldId: $fieldId, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }
}
