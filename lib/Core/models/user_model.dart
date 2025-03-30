import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? fullName;
  final String? email;
  final String? childName;
  final String? photoPath;

  UserModel({
    this.fullName,
    this.email,
    this.childName,
    this.photoPath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    fullName: json["fullName"],
    email: json["email"],
    childName: json["childName"],
    photoPath: json["photoPath"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "email": email,
    "childName": childName,
    "photoPath": photoPath,
  };
}