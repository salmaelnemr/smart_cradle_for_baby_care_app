import 'dart:convert';

BabyTempModel babyTempModelFromJson(String str) => BabyTempModel.fromJson(json.decode(str));

String babyTempModelToJson(BabyTempModel data) => json.encode(data.toJson());

class BabyTempModel {
  final double? temp;

  BabyTempModel({
    this.temp,
  });

  factory BabyTempModel.fromJson(Map<String, dynamic> json) => BabyTempModel(
    temp: json["temp"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
  };
}
