import 'dart:convert';

SensorDataStatusModel sensorDataStatusModelFromJson(String str) => SensorDataStatusModel.fromJson(json.decode(str));

String sensorDataStatusModelToJson(SensorDataStatusModel data) => json.encode(data.toJson());

class SensorDataStatusModel {
  final String babyTemp;
  final String weight;
  final String heartRate;
  final String sPo2;
  final String roomTemp;

  SensorDataStatusModel({
    required this.babyTemp,
    required this.weight,
    required this.heartRate,
    required this.sPo2,
    required this.roomTemp,
  });

  factory SensorDataStatusModel.fromJson(Map<String, dynamic> json) => SensorDataStatusModel(
    babyTemp: json["babyTemp"],
    weight: json["weight"],
    heartRate: json["heartRate"],
    sPo2: json["sPo2"],
    roomTemp: json["roomTemp"],
  );

  Map<String, dynamic> toJson() => {
    "babyTemp": babyTemp,
    "weight": weight,
    "heartRate": heartRate,
    "sPo2": sPo2,
    "roomTemp": roomTemp,
  };
}

