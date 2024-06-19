import 'package:dio/dio.dart';
import 'package:plantopia/helpers/user_token_preference.dart';

class MyPlantDetailsService {
  static Dio dio = Dio();

  static Future<String> deleteMyPlant(int plantId) async {
    try {
      final token = await UserTokenPref.getToken();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await dio.delete(
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/$plantId",
          data: {'user_plant_id': plantId},
          options: Options(headers: headers));
      return response.data['status'];
    } catch (e) {
      return "Failed to delete plant from my plant";
    }
  }

  static Future<void> createCustomName(int userPlantId, String name) async {
    try {
      final token = await UserTokenPref.getToken();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      await dio.put(
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/$userPlantId/customize-name",
          data: {"customize_name": name},
          options: Options(headers: headers));
    } catch (e) {
      throw Exception("Failed to delete plant from my plant");
    }
  }
}
