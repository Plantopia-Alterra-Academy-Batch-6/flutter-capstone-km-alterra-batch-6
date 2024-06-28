import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/models/get_plant_by_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/utils/base_url_util.dart';

class MyPlantService {
  static Dio dio = Dio();

  static Future<GetMyPlantResponse> getMyPlant() async {
    try {
      final token = await UserTokenPref.getToken();
      final userId = await UserTokenPref.getUserId();
      if (kDebugMode) {
        print("ini token $token $userId");
      }
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
          "${BaseUrlUtil.baseUrl}/my/plants/$userId",
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        return GetMyPlantResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load my plant data : ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load my plant data: $e');
    }
  }

  static Future<PlantRecommendationsResponse> getRecommendationPlant() async {
    try {
      final token = await UserTokenPref.getToken();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
          "${BaseUrlUtil.baseUrl}/plants/recommendations",
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        return PlantRecommendationsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to recommendations : ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to recommendations : $e');
    }
  }

  static Future<GetPlantByCategoryResponse> getPlantByCategories(int id) async {
    try {
      final response = await dio.get(
          "${BaseUrlUtil.baseUrl}/plants/category/$id");

      if (response.statusCode == 200) {
        return GetPlantByCategoryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get categories : ${response.statusCode}');
      }
    } on DioException catch (_) {
      return GetPlantByCategoryResponse(data: []);
    }
  }
}
