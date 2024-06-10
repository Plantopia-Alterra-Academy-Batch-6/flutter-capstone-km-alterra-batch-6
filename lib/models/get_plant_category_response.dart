class PlantCategoriesResponse {
  final String message;
  final int code;
  final String status;
  final List<PlantCategory> data;

  PlantCategoriesResponse({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory PlantCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return PlantCategoriesResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
      data: List<PlantCategory>.from(
        json['data'].map((item) => PlantCategory.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class PlantCategory {
  final int id;
  final String name;
  final String imageUrl;

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
