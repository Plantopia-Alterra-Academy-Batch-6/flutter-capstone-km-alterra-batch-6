// To parse this JSON data, do
//
//     final getPlantingCare = getPlantingCareFromJson(jsonString);

import 'dart:convert';

GetPlantingCare getPlantingCareFromJson(String str) => GetPlantingCare.fromJson(json.decode(str));

String getPlantingCareToJson(GetPlantingCare data) => json.encode(data.toJson());

class GetPlantingCare {
    String? message;
    int? code;
    String? status;
    List<PlantCaring>? data;

    GetPlantingCare({
        this.message,
        this.code,
        this.status,
        this.data,
    });

    factory GetPlantingCare.fromJson(Map<String, dynamic> json) => GetPlantingCare(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? [] : List<PlantCaring>.from(json["data"]!.map((x) => PlantCaring.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PlantCaring {
    int? id;
    int? plantId;
    int? wateringFrequency;
    String? each;
    int? wateringAmount;
    String? unit;
    String? wateringTime;
    String? weatherCondition;
    String? conditionDescription;

    PlantCaring({
        this.id,
        this.plantId,
        this.wateringFrequency,
        this.each,
        this.wateringAmount,
        this.unit,
        this.wateringTime,
        this.weatherCondition,
        this.conditionDescription,
    });

    factory PlantCaring.fromJson(Map<String, dynamic> json) => PlantCaring(
        id: json["id"],
        plantId: json["plant_id"],
        wateringFrequency: json["watering_frequency"],
        each: json["each"],
        wateringAmount: json["watering_amount"],
        unit: json["unit"],
        wateringTime: json["watering_time"],
        weatherCondition: json["weather_condition"],
        conditionDescription: json["condition_description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "watering_frequency": wateringFrequency,
        "each": each,
        "watering_amount": wateringAmount,
        "unit": unit,
        "watering_time": wateringTime,
        "weather_condition": weatherCondition,
        "condition_description": conditionDescription,
    };
}
