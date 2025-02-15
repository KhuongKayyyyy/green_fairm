class WaterHistory {
  String? id;
  String? fieldId;
  String? startDate;
  String? endDate;
  String? createdAt;

  WaterHistory(
      {this.id, this.fieldId, this.startDate, this.endDate, this.createdAt});

  factory WaterHistory.fromJson(Map<String, dynamic> json) {
    return WaterHistory(
      id: json['_id'],
      fieldId: json['fieldId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fieldId': fieldId,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'WaterHistory{id: $id, startDate: $startDate, endDate: $endDate, createdAt: $createdAt}';
  }
}
