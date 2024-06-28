

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final bool? isActive;
  final String? otp;
  final String? urlImage;
  final String? fcmToken;
  final DateTime? createdAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.otp,
    this.urlImage,
    this.fcmToken,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        isActive: json["is_active"],
        otp: json["otp"],
        urlImage: json["url_image"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "is_active": isActive,
        "otp": otp,
        "url_image": urlImage,
        "fcm_token": fcmToken,
        "created_at": createdAt?.toIso8601String(),
      };
}
