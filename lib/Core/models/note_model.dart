import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) => List<NoteModel>.from(json.decode(str).map((x) => NoteModel.fromJson(x)));

String noteModelToJson(List<NoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoteModel {
  final int? id;
  final String? title;
  final String? content;
  final DateTime? time;

  NoteModel({
    this.id,
    this.title,
    this.content,
    this.time,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "time": time?.toIso8601String(),
  };
}
