

import 'dart:convert';

SignUpParamsModel signUpParamsModelFromJson(String str) =>
    SignUpParamsModel.fromJson(json.decode(str));

String signUpParamsModelToJson(SignUpParamsModel data) =>
    json.encode(data.toJson());

class SignUpParamsModel {
  final String? name;
  final String? email;
  final String? password;
  String? fcmToken;

  SignUpParamsModel({
    this.name,
    this.email,
    this.password,
    this.fcmToken,
  });

  factory SignUpParamsModel.fromJson(Map<String, dynamic> json) =>
      SignUpParamsModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
      };
}
