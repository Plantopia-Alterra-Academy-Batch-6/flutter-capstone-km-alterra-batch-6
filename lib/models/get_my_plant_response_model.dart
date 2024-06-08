// To parse this JSON data, do
//
//     final getMyPlantResponse = getMyPlantResponseFromJson(jsonString);

import 'dart:convert';

GetMyPlantResponse getMyPlantResponseFromJson(String str) => GetMyPlantResponse.fromJson(json.decode(str));

String getMyPlantResponseToJson(GetMyPlantResponse data) => json.encode(data.toJson());

class GetMyPlantResponse {
    String? message;
    int? code;
    String? status;
    Data? data;

    GetMyPlantResponse({
        this.message,
        this.code,
        this.status,
        this.data,
    });

    factory GetMyPlantResponse.fromJson(Map<String, dynamic> json) => GetMyPlantResponse(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? userId;
    List<PlantElement>? plants;
    int? limit;
    int? page;
    int? totalCount;
    int? totalPages;

    Data({
        this.userId,
        this.plants,
        this.limit,
        this.page,
        this.totalCount,
        this.totalPages,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        plants: json["plants"] == null ? [] : List<PlantElement>.from(json["plants"]!.map((x) => PlantElement.fromJson(x))),
        limit: json["limit"],
        page: json["page"],
        totalCount: json["total_count"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "plants": plants == null ? [] : List<dynamic>.from(plants!.map((x) => x.toJson())),
        "limit": limit,
        "page": page,
        "total_count": totalCount,
        "total_pages": totalPages,
    };
}

class PlantElement {
    int? id;
    PlantPlant? plant;
    DateTime? createdAt;

    PlantElement({
        this.id,
        this.plant,
        this.createdAt,
    });

    factory PlantElement.fromJson(Map<String, dynamic> json) => PlantElement(
        id: json["id"],
        plant: json["plant"] == null ? null : PlantPlant.fromJson(json["plant"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plant": plant?.toJson(),
        "created_at": createdAt?.toIso8601String(),
    };
}

class PlantPlant {
    int? id;
    String? name;
    String? description;
    bool? isToxic;
    int? harvestDuration;
    PlantCategory? plantCategory;
    String? climateCondition;
    String? plantingTime;
    String? sunlight;
    PlantCharacteristic? plantCharacteristic;
    WateringSchedule? wateringSchedule;
    List<PlantInstruction>? plantInstructions;
    List<PlantFaq>? plantFaqs;
    List<PlantImage>? plantImages;
    DateTime? createdAt;

    PlantPlant({
        this.id,
        this.name,
        this.description,
        this.isToxic,
        this.harvestDuration,
        this.plantCategory,
        this.climateCondition,
        this.plantingTime,
        this.sunlight,
        this.plantCharacteristic,
        this.wateringSchedule,
        this.plantInstructions,
        this.plantFaqs,
        this.plantImages,
        this.createdAt,
    });

    factory PlantPlant.fromJson(Map<String, dynamic> json) => PlantPlant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isToxic: json["is_toxic"],
        harvestDuration: json["harvest_duration"],
        plantCategory: json["plant_category"] == null ? null : PlantCategory.fromJson(json["plant_category"]),
        climateCondition: json["climate_condition"],
        plantingTime: json["planting_time"],
        sunlight: json["sunlight"],
        plantCharacteristic: json["plant_characteristic"] == null ? null : PlantCharacteristic.fromJson(json["plant_characteristic"]),
        wateringSchedule: json["watering_schedule"] == null ? null : WateringSchedule.fromJson(json["watering_schedule"]),
        plantInstructions: json["plant_instructions"] == null ? [] : List<PlantInstruction>.from(json["plant_instructions"]!.map((x) => PlantInstruction.fromJson(x))),
        plantFaqs: json["plant_faqs"] == null ? [] : List<PlantFaq>.from(json["plant_faqs"]!.map((x) => PlantFaq.fromJson(x))),
        plantImages: json["plant_images"] == null ? [] : List<PlantImage>.from(json["plant_images"]!.map((x) => PlantImage.fromJson(x))),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_toxic": isToxic,
        "harvest_duration": harvestDuration,
        "plant_category": plantCategory?.toJson(),
        "climate_condition": climateCondition,
        "planting_time": plantingTime,
        "sunlight": sunlight,
        "plant_characteristic": plantCharacteristic?.toJson(),
        "watering_schedule": wateringSchedule?.toJson(),
        "plant_instructions": plantInstructions == null ? [] : List<dynamic>.from(plantInstructions!.map((x) => x.toJson())),
        "plant_faqs": plantFaqs == null ? [] : List<dynamic>.from(plantFaqs!.map((x) => x.toJson())),
        "plant_images": plantImages == null ? [] : List<dynamic>.from(plantImages!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
    };
}

class PlantCategory {
    int? id;
    String? name;
    String? imageUrl;

    PlantCategory({
        this.id,
        this.name,
        this.imageUrl,
    });

    factory PlantCategory.fromJson(Map<String, dynamic> json) => PlantCategory(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
    };
}

class PlantCharacteristic {
    int? id;
    int? height;
    String? heightUnit;
    int? wide;
    String? wideUnit;
    String? leafColor;

    PlantCharacteristic({
        this.id,
        this.height,
        this.heightUnit,
        this.wide,
        this.wideUnit,
        this.leafColor,
    });

    factory PlantCharacteristic.fromJson(Map<String, dynamic> json) => PlantCharacteristic(
        id: json["id"],
        height: json["height"],
        heightUnit: json["height_unit"],
        wide: json["wide"],
        wideUnit: json["wide_unit"],
        leafColor: json["leaf_color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
        "height_unit": heightUnit,
        "wide": wide,
        "wide_unit": wideUnit,
        "leaf_color": leafColor,
    };
}

class PlantFaq {
    int? id;
    int? plantId;
    String? question;
    String? answer;
    DateTime? createdAt;

    PlantFaq({
        this.id,
        this.plantId,
        this.question,
        this.answer,
        this.createdAt,
    });

    factory PlantFaq.fromJson(Map<String, dynamic> json) => PlantFaq(
        id: json["id"],
        plantId: json["plant_id"],
        question: json["question"],
        answer: json["answer"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "question": question,
        "answer": answer,
        "created_at": createdAt?.toIso8601String(),
    };
}

class PlantImage {
    int? id;
    int? plantId;
    String? fileName;
    int? isPrimary;

    PlantImage({
        this.id,
        this.plantId,
        this.fileName,
        this.isPrimary,
    });

    factory PlantImage.fromJson(Map<String, dynamic> json) => PlantImage(
        id: json["id"],
        plantId: json["plant_id"],
        fileName: json["file_name"],
        isPrimary: json["is_primary"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "file_name": fileName,
        "is_primary": isPrimary,
    };
}

class PlantInstruction {
    int? id;
    int? plantId;
    int? stepNumber;
    String? stepTitle;
    String? stepDescription;
    String? stepImageUrl;
    String? additionalTips;

    PlantInstruction({
        this.id,
        this.plantId,
        this.stepNumber,
        this.stepTitle,
        this.stepDescription,
        this.stepImageUrl,
        this.additionalTips,
    });

    factory PlantInstruction.fromJson(Map<String, dynamic> json) => PlantInstruction(
        id: json["id"],
        plantId: json["plant_id"],
        stepNumber: json["step_number"],
        stepTitle: json["step_title"],
        stepDescription: json["step_description"],
        stepImageUrl: json["step_image_url"],
        additionalTips: json["additional_tips"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "step_number": stepNumber,
        "step_title": stepTitle,
        "step_description": stepDescription,
        "step_image_url": stepImageUrl,
        "additional_tips": additionalTips,
    };
}

class WateringSchedule {
    int? id;
    int? plantId;
    int? wateringFrequency;
    String? each;
    int? wateringAmount;
    String? unit;
    String? wateringTime;
    String? weatherCondition;
    String? conditionDescription;

    WateringSchedule({
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

    factory WateringSchedule.fromJson(Map<String, dynamic> json) => WateringSchedule(
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
