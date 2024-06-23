class PlantByIdResponse {
  final String? message;
  final int? code;
  final String? status;
  final PlantData? data;

  PlantByIdResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory PlantByIdResponse.fromJson(Map<String, dynamic> json) {
    return PlantByIdResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: PlantData.fromJson(json['data']),
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
  final String? additionalTips;
  final List<PlantFaq>? plantFaqs;
  final List<PlantImage>? plantImages;
  final String? createdAt;

  PlantData({
    required this.id,
    required this.name,
    required this.description,
    required this.isToxic,
    required this.harvestDuration,
    required this.plantCategory,
    required this.climateCondition,
    required this.plantingTime,
    required this.sunlight,
    required this.plantCharacteristic,
    required this.wateringSchedule,
    required this.plantInstructions,
    required this.additionalTips,
    required this.plantFaqs,
    required this.plantImages,
    required this.createdAt,
  });

  factory PlantData.fromJson(Map<String, dynamic> json) {
    var plantInstructionsList = json['plant_instructions'] as List?;
    var plantFaqsList = json['plant_faqs'] as List?;
    var plantImagesList = json['plant_images'] as List?;

    return PlantData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isToxic: json['is_toxic'],
      harvestDuration: json['harvest_duration'],
      plantCategory: PlantCategory.fromJson(json['plant_category']),
      climateCondition: json['climate_condition'],
      plantingTime: json['planting_time'],
      sunlight: json['sunlight'],
      plantCharacteristic:
          PlantCharacteristic.fromJson(json['plant_characteristic']),
      wateringSchedule: WateringSchedule.fromJson(json['watering_schedule']),
      plantInstructions: plantInstructionsList
          ?.map((i) => PlantInstruction.fromJson(i))
          .toList(),
      additionalTips: json['additional_tips'],
      plantFaqs: plantFaqsList?.map((i) => PlantFaq.fromJson(i)).toList(),
      plantImages: plantImagesList?.map((i) => PlantImage.fromJson(i)).toList(),
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
      'plant_instructions': plantInstructions?.map((i) => i.toJson()).toList(),
      'additional_tips': additionalTips,
      'plant_faqs': plantFaqs?.map((i) => i.toJson()).toList(),
      'plant_images': plantImages?.map((i) => i.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}

class PlantCategory {
  final int? id;
  final String? name;
  final String? imageUrl;

  PlantCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
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
    required this.id,
    required this.height,
    required this.heightUnit,
    required this.wide,
    required this.wideUnit,
    required this.leafColor,
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
    required this.id,
    required this.plantId,
    required this.wateringFrequency,
    required this.each,
    required this.wateringAmount,
    required this.unit,
    required this.wateringTime,
    required this.weatherCondition,
    required this.conditionDescription,
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

  PlantInstruction({
    required this.id,
    required this.plantId,
    required this.instructionCategory,
    required this.stepNumber,
    required this.stepTitle,
    required this.stepDescription,
    required this.stepImageUrl,
  });

  factory PlantInstruction.fromJson(Map<String, dynamic> json) {
    return PlantInstruction(
      id: json['id'],
      plantId: json['plant_id'],
      instructionCategory:
          InstructionCategory.fromJson(json['instruction_category']),
      stepNumber: json['step_number'],
      stepTitle: json['step_title'],
      stepDescription: json['step_description'],
      stepImageUrl: json['step_image_url'],
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
    };
  }
}

class InstructionCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;

  InstructionCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
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
    required this.id,
    required this.plantId,
    required this.question,
    required this.answer,
    required this.createdAt,
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
    required this.id,
    required this.plantId,
    required this.fileName,
    required this.isPrimary,
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
