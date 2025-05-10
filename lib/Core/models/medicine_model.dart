import 'dart:convert';

List<MedicineModel> medicineModelFromJson(String str) => List<MedicineModel>.from(json.decode(str).map((x) => MedicineModel.fromJson(x)));

String medicineModelToJson(List<MedicineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicineModel {
  final int? id;
  final String? medicineName;
  final String? content;
  final DateTime? notificationTime;

  MedicineModel({
    this.id,
    this.medicineName,
    this.content,
    this.notificationTime,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
    id: json["id"],
    medicineName: json["medicineName"],
    content: json["content"],
    notificationTime: json["notificationTime"] == null ? null : DateTime.parse(json["notificationTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "medicineName": medicineName,
    "content": content,
    "notificationTime": notificationTime?.toIso8601String(),
  };
}
