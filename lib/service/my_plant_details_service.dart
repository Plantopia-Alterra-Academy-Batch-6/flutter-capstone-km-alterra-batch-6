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
      print("Failed to delete data $e");
      return "Failed";
    }
  }
}
