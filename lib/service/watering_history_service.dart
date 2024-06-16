import 'package:dio/dio.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_watering_history_response.dart';

class WateringHistoryService {
  static Dio dio = Dio();

  static Future<GetWateringHistoryResponse> getWateringHistory() async {
    try {
      final token = await UserTokenPref.getToken();
      print("hello token $token");
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/watering-history",
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return GetWateringHistoryResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load planting history data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> postWatering(int plantId) async {
    try {
      final token = await UserTokenPref.getToken();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      await dio.post(
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/watering-history",
        data: {"plant_id": plantId},
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
