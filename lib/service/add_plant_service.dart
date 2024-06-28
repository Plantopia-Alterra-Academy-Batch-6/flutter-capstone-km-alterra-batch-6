import 'package:dio/dio.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/utils/base_url_util.dart';

class AddPlantService {
  final Dio dio = Dio();

  Future<PlantCategoriesResponse> getAllPlantCategory() async {
    const api =
        "${BaseUrlUtil.baseUrl}/plants/categories";
    final response = await dio.get(api);

    if (response.statusCode == 200) {
      return PlantCategoriesResponse.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to get all plant category: ${response.statusCode}");
    }
  }

  Future<PlantRecommendationsResponse> getPlantRecommendations() async {
    final token = await UserTokenPref.getToken();
    const api =
        '${BaseUrlUtil.baseUrl}/plants/recommendations';
    var header = {
      'Authorization': 'Bearer $token',
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
