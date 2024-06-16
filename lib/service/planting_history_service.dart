import 'package:dio/dio.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_panting_history_response.dart';

class PlantingHistoryService {
  static Dio dio = Dio();

  static Future<GetPlantingHistoryResponse> getPlantingHistory() async {
    try {
      final token = await UserTokenPref.getToken();
      print("hello token $token");
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/history",
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return GetPlantingHistoryResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load planting history data : ${response.statusCode}');
      }
    } on DioException catch (_) {
      throw Exception('Failed to load planting history data');
    }
  }

  static Future<void> addPlantingHistory(int plantId) async {
    try {
      final token = await UserTokenPref.getToken();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      await dio.post(
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/history",
        data: {"plant_id": plantId},
        options: Options(
          headers: headers,
        ),
      );
    } on DioException catch (_) {
      throw Exception('Failed to load planting history data');
    }
  }
}
