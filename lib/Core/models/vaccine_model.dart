
import 'dart:convert';

List<VaccineModel> vaccineModelFromJson(String str) => List<VaccineModel>.from(json.decode(str).map((x) => VaccineModel.fromJson(x)));

String vaccineModelToJson(List<VaccineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VaccineModel {
  final String? vaccineName;
  final String? content;
  final DateTime? date;

  VaccineModel({
    this.vaccineName,
    this.content,
    this.date,
  });

  factory VaccineModel.fromJson(Map<String, dynamic> json) => VaccineModel(
    vaccineName: json["vaccineName"],
    content: json["content"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "vaccineName": vaccineName,
    "content": content,
    "date": date?.toIso8601String(),
  };
}
