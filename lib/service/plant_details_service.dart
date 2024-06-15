
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';

class PlantDetailsService {
  Dio dio = Dio();
  
  Future<PlantByIdResponse> getPlantById(int id) async {
    try {
      final api = "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/$id";
      final response = await dio.get(api);

      if (response.statusCode == 200) {
        return PlantByIdResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to get plant by id: ${response.statusCode}");
      }
    } on DioException {
      throw Exception("Failed to get plant id");
    }
  }

  Future<void> addPlant(int id) async {
    final token = await UserTokenPref.getToken();
    const api =
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/my/plants/add";
    final headers = {
      'Authorization': 'Bearer $token'
    };
    final body = {'plant_id': id};

    final response = await dio.post(api, data: body, options: Options(headers: headers));

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print("success add plant");
      }
    }
    else {
      throw Exception("Failed to add plant");
    }
  }
}