class PlantRecommendationsResponse {
  final String? message;
  final int? code;
  final String? status;
  final List<Plant>? data;

  PlantRecommendationsResponse({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory PlantRecommendationsResponse.fromJson(Map<String, dynamic> json) {
    return PlantRecommendationsResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Plant.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class Plant {
  final int? id;
  final String? name;
  final String? description;
  final bool? isToxic;
  final int? harvestDuration;
  final PlantCategory? plantCategory;
  final String? climateCondition;
  final String? plantingTime;
  final String? sunlight;
  final PlantCharacteristic? plantCharacteristic;
  final WateringSchedule? wateringSchedule;
  final List<PlantInstruction>? plantInstructions;
  final List<PlantFaq>? plantFaqs;
  final List<PlantImage>? plantImages;
  final String? createdAt;

  Plant({
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

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isToxic: json['is_toxic'],
      harvestDuration: json['harvest_duration'],
      plantCategory: json['plant_category'] != null
          ? PlantCategory.fromJson(json['plant_category'])
          : null,
      climateCondition: json['climate_condition'],
      plantingTime: json['planting_time'],
      sunlight: json['sunlight'],
      plantCharacteristic: json['plant_characteristic'] != null
          ? PlantCharacteristic.fromJson(json['plant_characteristic'])
          : null,
      wateringSchedule: json['watering_schedule'] != null
          ? WateringSchedule.fromJson(json['watering_schedule'])
          : null,
      plantInstructions: (json['plant_instructions'] as List<dynamic>?)
          ?.map((item) => PlantInstruction.fromJson(item))
          .toList(),
      plantFaqs: (json['plant_faqs'] as List<dynamic>?)
          ?.map((item) => PlantFaq.fromJson(item))
          .toList(),
      plantImages: (json['plant_images'] as List<dynamic>?)
          ?.map((item) => PlantImage.fromJson(item))
          .toList(),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_toxic': isToxic,
      'harvest_duration': harvestDuration,
      'plant_category': plantCategory?.toJson(),
      'climate_condition': climateCondition,
      'planting_time': plantingTime,
      'sunlight': sunlight,
      'plant_characteristic': plantCharacteristic?.toJson(),
      'watering_schedule': wateringSchedule?.toJson(),
      'plant_instructions': plantInstructions?.map((item) => item.toJson()).toList(),
      'plant_faqs': plantFaqs?.map((item) => item.toJson()).toList(),
      'plant_images': plantImages?.map((item) => item.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}

class PlantCategory {
  final int? id;
  final String? name;
  final String? imageUrl;

  PlantCategory({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory PlantCategory.fromJson(Map<String, dynamic> json) {
    return PlantCategory(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}

class PlantCharacteristic {
  final int? id;
  final int? height;
  final String? heightUnit;
  final int? wide;
  final String? wideUnit;
  final String? leafColor;

  PlantCharacteristic({
    this.id,
    this.height,
    this.heightUnit,
    this.wide,
    this.wideUnit,
    this.leafColor,
  });

  factory PlantCharacteristic.fromJson(Map<String, dynamic> json) {
    return PlantCharacteristic(
      id: json['id'],
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
    };
  }
}

class PlantInstruction {
  final int? id;
  final int? plantId;
  final InstructionCategory? instructionCategory;
  final int? stepNumber;
  final String? stepTitle;
  final String? stepDescription;
  final String? stepImageUrl;
  final String? additionalTips;

  PlantInstruction({
    this.id,
    this.plantId,
    this.instructionCategory,
    this.stepNumber,
    this.stepTitle,
    this.stepDescription,
    this.stepImageUrl,
    this.additionalTips,
  });

  factory PlantInstruction.fromJson(Map<String, dynamic> json) {
    return PlantInstruction(
      id: json['id'],
      plantId: json['plant_id'],
      instructionCategory: json['instruction_category'] != null
          ? InstructionCategory.fromJson(json['instruction_category'])
          : null,
      stepNumber: json['step_number'],
      stepTitle: json['step_title'],
      stepDescription: json['step_description'],
      stepImageUrl: json['step_image_url'],
      additionalTips: json['additional_tips'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'instruction_category': instructionCategory?.toJson(),
      'step_number': stepNumber,
      'step_title': stepTitle,
      'step_description': stepDescription,
      'step_image_url': stepImageUrl,
      'additional_tips': additionalTips,
    };
  }
}

class InstructionCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;

  InstructionCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory InstructionCategory.fromJson(Map<String, dynamic> json) {
    return InstructionCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
    };
  }
}

class PlantFaq {
  final int? id;
  final int? plantId;
  final String? question;
  final String? answer;
  final String? createdAt;

  PlantFaq({
    this.id,
    this.plantId,
    this.question,
    this.answer,
    this.createdAt,
  });

  factory PlantFaq.fromJson(Map<String, dynamic> json) {
    return PlantFaq(
      id: json['id'],
      plantId: json['plant_id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'question': question,
      'answer': answer,
      'created_at': createdAt,
    };
  }
}

class PlantImage {
  final int? id;
  final int? plantId;
  final String? fileName;
  final int? isPrimary;

  PlantImage({
    this.id,
    this.plantId,
    this.fileName,
    this.isPrimary,
  });

  factory PlantImage.fromJson(Map<String, dynamic> json) {
    return PlantImage(
      id: json['id'],
      plantId: json['plant_id'],
      fileName: json['file_name'],
      isPrimary: json['is_primary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'file_name': fileName,
      'is_primary': isPrimary,
    };
  }
}
