class Field {
  String? id;
  String? name;
  String? status;
  String? type;
  String? area;
  String? imageUrl;
  String? plantingDate;
  String? cropHealth;
  String? haverstTime;
  bool? isAutoWatering;
  bool? isWeatherService;

  Field({
    this.id,
    this.name,
    this.status,
    this.type,
    this.area,
    this.imageUrl,
    this.plantingDate,
    this.cropHealth,
    this.haverstTime,
    this.isAutoWatering,
    this.isWeatherService,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['_id'],
      name: json['name'],
      // status: json['status'],
      // type: json['type'],
      area: json['area'],
      imageUrl: "https://img-cdn.krishijagran.com/99864/krishi-dss.jpg",
      // plantingDate: json['plantingDate'],
      // cropHealth: json['cropHealth'],
      // haverstTime: json['haverstTime'],
      isAutoWatering: json['isAutoWatering'],
      isWeatherService: json['isWeather'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'type': type,
      'area': area,
      'imageUrl': imageUrl,
      'plantingDate': plantingDate,
      'cropHealth': cropHealth,
      'haverstTime': haverstTime,
    };
  }

  @override
  String toString() {
    return 'Field{id: $id, name: $name, status: $status, type: $type, area: $area, imageUrl: $imageUrl, plantingDate: $plantingDate, cropHealth: $cropHealth, haverstTime: $haverstTime, isAutoWatering: $isAutoWatering, isWeatherService: $isWeatherService}';
  }
}
