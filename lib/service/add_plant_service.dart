import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';

class AddPlantService {
  final Dio dio = Dio();

  void addPlant(int id) {
    const api =
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/add";
    final headers = {
      'Authorization': 'Bearer '
    };
    final body = {'plant_id': id};
  }

  Future<PlantCategoriesResponse> getAllPlantCategory() async {
    const api =
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/categories";
    final response = await dio.get(api);

    if (response.statusCode == 200) {
      return PlantCategoriesResponse.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to get all plant category: ${response.statusCode}");
    }
  }

  Future<PlantRecommendationsResponse> getPlantRecommendations() async {
    const api =
        'https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/recommendations';
    var header = {
      'Authorization': 'Bearer ${dotenv.get('bearerToken')}',
    };

    final dio = Dio();
    final response = await dio.get(
      api,
      options: Options(headers: header),
    );

    if (response.statusCode == 200) {
      return PlantRecommendationsResponse.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to get plant recommendation: ${response.statusCode}");
    }
  }
}
