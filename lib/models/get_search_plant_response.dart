class SearchedPlantResponse {
  final String? message;
  final int? code;
  final String? status;
  final PlantData? data;

  SearchedPlantResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory SearchedPlantResponse.fromJson(Map<String, dynamic> json) {
    return SearchedPlantResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: json['data'] != null ? PlantData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class PlantData {
  final List<Plant>? plants;
  final int? totalCount;
  final int? limit;
  final int? page;
  final int? totalPages;

  PlantData({
    required this.plants,
    required this.totalCount,
    required this.limit,
    required this.page,
    required this.totalPages,
  });

  factory PlantData.fromJson(Map<String, dynamic> json) {
    return PlantData(
      plants: json['plants'] != null ? List<Plant>.from(json['plants'].map((item) => Plant.fromJson(item))) : null,
      totalCount: json['total_count'],
      limit: json['limit'],
      page: json['page'],
      totalPages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plants': plants?.map((item) => item.toJson()).toList(),
      'total_count': totalCount,
      'limit': limit,
      'page': page,
      'total_pages': totalPages,
    };
  }
}

class Plant {
  final int? id;
  final String? name;
  final String? description;
  final bool? isToxic;
  final int? harvestDuration;
  final String? sunlight;
  final String? plantingTime;
  final int? plantCategoryId;
  final PlantCategory? plantCategory;
  final String? climateCondition;
  final int? plantCharacteristicId;
  final PlantCharacteristic? plantCharacteristic;
  final WateringSchedule? wateringSchedule;
  final List<PlantInstruction>? plantInstructions;
  final String? additionalTips;
  final List<PlantFaq>? plantFaqs;
  final List<PlantImage>? plantImages;
  final String? createdAt;
  final String? updatedAt;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    required this.isToxic,
    required this.harvestDuration,
    required this.sunlight,
    required this.plantingTime,
    required this.plantCategoryId,
    required this.plantCategory,
    required this.climateCondition,
    required this.plantCharacteristicId,
    required this.plantCharacteristic,
    required this.wateringSchedule,
    required this.plantInstructions,
    required this.additionalTips,
    required this.plantFaqs,
    required this.plantImages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isToxic: json['is_toxic'],
      harvestDuration: json['harvest_duration'],
      sunlight: json['sunlight'],
      plantingTime: json['planting_time'],
      plantCategoryId: json['plant_category_id'],
      plantCategory: json['plant_category'] != null ? PlantCategory.fromJson(json['plant_category']) : null,
      climateCondition: json['climate_condition'],
      plantCharacteristicId: json['plant_characteristic_id'],
      plantCharacteristic: json['plant_characteristic'] != null ? PlantCharacteristic.fromJson(json['plant_characteristic']) : null,
      wateringSchedule: json['watering_schedule'] != null ? WateringSchedule.fromJson(json['watering_schedule']) : null,
      plantInstructions: json['plant_instructions'] != null ? List<PlantInstruction>.from(json['plant_instructions'].map((item) => PlantInstruction.fromJson(item))) : null,
      additionalTips: json['additional_tips'],
      plantFaqs: json['plant_faqs'] != null ? List<PlantFaq>.from(json['plant_faqs'].map((item) => PlantFaq.fromJson(item))) : null,
      plantImages: json['plant_images'] != null ? List<PlantImage>.from(json['plant_images'].map((item) => PlantImage.fromJson(item))) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_toxic': isToxic,
      'harvest_duration': harvestDuration,
      'sunlight': sunlight,
      'planting_time': plantingTime,
      'plant_category_id': plantCategoryId,
      'plant_category': plantCategory?.toJson(),
      'climate_condition': climateCondition,
      'plant_characteristic_id': plantCharacteristicId,
      'plant_characteristic': plantCharacteristic?.toJson(),
      'watering_schedule': wateringSchedule?.toJson(),
      'plant_instructions': plantInstructions?.map((item) => item.toJson()).toList(),
      'additional_tips': additionalTips,
      'plant_faqs': plantFaqs?.map((item) => item.toJson()).toList(),
      'plant_images': plantImages?.map((item) => item.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PlantCategory {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;

  PlantCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlantCategory.fromJson(Map<String, dynamic> json) {
    return PlantCategory(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PlantCharacteristic {
  final int? id;
  final int? plantId;
  final int? height;
  final String? heightUnit;
  final int? wide;
  final String? wideUnit;
  final String? leafColor;

  PlantCharacteristic({
    required this.id,
    required this.plantId,
    required this.height,
    required this.heightUnit,
    required this.wide,
    required this.wideUnit,
    required this.leafColor,
  });

  factory PlantCharacteristic.fromJson(Map<String, dynamic> json) {
    return PlantCharacteristic(
      id: json['id'],
      plantId: json['plant_id'],
      height: json['height'],
      heightUnit: json['height_unit'],
      wide: json['wide'],
      wideUnit: json['wide_unit'],
      leafColor: json['leaf_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'height': height,
      'height_unit': heightUnit,
      'wide': wide,
      'wide_unit': wideUnit,
      'leaf_color': leafColor,
    };
  }
}

class WateringSchedule {
  final int? id;
  final int? plantId;
  final int? wateringFrequency;
  final String? each;
  final int? wateringAmount;
  final String? unit;
  final String? wateringTime;
  final String? weatherCondition;
  final String? conditionDescription;
  final String? createdAt;
  final String? updatedAt;

  WateringSchedule({
    required this.id,
    required this.plantId,
    required this.wateringFrequency,
    required this.each,
    required this.wateringAmount,
    required this.unit,
    required this.wateringTime,
    required this.weatherCondition,
    required this.conditionDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WateringSchedule.fromJson(Map<String, dynamic> json) {
    return WateringSchedule(
      id: json['id'],
      plantId: json['plant_id'],
      wateringFrequency: json['watering_frequency'],
      each: json['each'],
      wateringAmount: json['watering_amount'],
      unit: json['unit'],
      wateringTime: json['watering_time'],
      weatherCondition: json['weather_condition'],
      conditionDescription: json['condition_description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'watering_frequency': wateringFrequency,
      'each': each,
      'watering_amount': wateringAmount,
      'unit': unit,
      'watering_time': wateringTime,
      'weather_condition': weatherCondition,
      'condition_description': conditionDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PlantInstruction {
  final int? id;
  final int? plantId;
  final int? instructionCategoryId;
  final InstructionCategory? instructionCategory;
  final int? stepNumber;
  final String? stepTitle;
  final String? stepDescription;
  final String? stepImageUrl;
  final String? createdAt;
  final String? updatedAt;

  PlantInstruction({
    required this.id,
    required this.plantId,
    required this.instructionCategoryId,
    required this.instructionCategory,
    required this.stepNumber,
    required this.stepTitle,
    required this.stepDescription,
    required this.stepImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlantInstruction.fromJson(Map<String, dynamic> json) {
    return PlantInstruction(
      id: json['id'],
      plantId: json['plant_id'],
      instructionCategoryId: json['instruction_category_id'],
      instructionCategory: json['instruction_category'] != null ? InstructionCategory.fromJson(json['instruction_category']) : null,
      stepNumber: json['step_number'],
      stepTitle: json['step_title'],
      stepDescription: json['step_description'],
      stepImageUrl: json['step_image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'instruction_category_id': instructionCategoryId,
      'instruction_category': instructionCategory?.toJson(),
      'step_number': stepNumber,
      'step_title': stepTitle,
      'step_description': stepDescription,
      'step_image_url': stepImageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class InstructionCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;

  InstructionCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InstructionCategory.fromJson(Map<String, dynamic> json) {
    return InstructionCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PlantFaq {
  final int? id;
  final int? plantId;
  final String? question;
  final String? answer;
  final String? createdAt;
  final String? updatedAt;

  PlantFaq({
    required this.id,
    required this.plantId,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlantFaq.fromJson(Map<String, dynamic> json) {
    return PlantFaq(
      id: json['id'],
      plantId: json['plant_id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'question': question,
      'answer': answer,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PlantImage {
  final int? id;
  final int? plantId;
  final String? fileName;
  final int? isPrimary;
  final String? createdAt;
  final String? updatedAt;

  PlantImage({
    required this.id,
    required this.plantId,
    required this.fileName,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlantImage.fromJson(Map<String, dynamic> json) {
    return PlantImage(
      id: json['id'],
      plantId: json['plant_id'],
      fileName: json['file_name'],
      isPrimary: json['is_primary'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'file_name': fileName,
      'is_primary': isPrimary,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
