import 'package:dio/dio.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class MyPlantService {
  static Dio dio = Dio();

  static Future<GetMyPlantResponse> getMyPlant() async {
    try {
      final token = await UserTokenPref.getToken();
      final userId = await UserTokenPref.getUserId();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/$userId",
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
}
