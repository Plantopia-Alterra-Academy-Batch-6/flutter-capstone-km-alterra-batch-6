// To parse this JSON data, do
//
//     final loginParamsModel = loginParamsModelFromJson(jsonString);

import 'dart:convert';

LoginParamsModel loginParamsModelFromJson(String str) =>
    LoginParamsModel.fromJson(json.decode(str));

String loginParamsModelToJson(LoginParamsModel data) =>
    json.encode(data.toJson());

class LoginParamsModel {
  final String? email;
  final String? password;
  String? fcmToken;

  LoginParamsModel({
    this.email,
    this.password,
    this.fcmToken,
  });

  factory LoginParamsModel.fromJson(Map<String, dynamic> json) =>
      LoginParamsModel(
        email: json["email"],
        password: json["password"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
      };
}
