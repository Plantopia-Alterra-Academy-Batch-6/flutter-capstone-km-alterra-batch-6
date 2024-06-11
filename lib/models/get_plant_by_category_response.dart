// To parse this JSON data, do
//
//     final getPlantByCategoryResponse = getPlantByCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:plantopia/models/get_plant_recommendations_response.dart';

GetPlantByCategoryResponse getPlantByCategoryResponseFromJson(String str) => GetPlantByCategoryResponse.fromJson(json.decode(str));

String getPlantByCategoryResponseToJson(GetPlantByCategoryResponse data) => json.encode(data.toJson());

class GetPlantByCategoryResponse {
    String? message;
    int? code;
    String? status;
    List<Plant>? data;

    GetPlantByCategoryResponse({
        this.message,
        this.code,
        this.status,
        this.data,
    });

    factory GetPlantByCategoryResponse.fromJson(Map<String, dynamic> json) => GetPlantByCategoryResponse(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? [] : List<Plant>.from(json["data"]!.map((x) => Plant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}



