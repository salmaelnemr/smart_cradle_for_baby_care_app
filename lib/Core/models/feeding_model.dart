import 'dart:convert';

List<FeedingModel> feedingModelFromJson(String str) => List<FeedingModel>.from(json.decode(str).map((x) => FeedingModel.fromJson(x)));

String feedingModelToJson(List<FeedingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedingModel {
  final int? id;
  final String? content;
  final DateTime? time;

  FeedingModel({
    this.id,
    this.content,
    this.time,
  });

  factory FeedingModel.fromJson(Map<String, dynamic> json) => FeedingModel(
    id: json["id"],
    content: json["content"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "time": time?.toIso8601String(),
  };
}
