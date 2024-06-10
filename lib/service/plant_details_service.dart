import 'package:dio/dio.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';

class PlantDetailsService {
  Dio dio = Dio();
  
  Future<PlantByIdResponse> getPlantById(int id) async {
    final api = "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/$id";
    final response = await dio.get(api);

    if (response.statusCode == 200) {
      return PlantByIdResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to get plant by id: ${response.statusCode}");
    }
  }
}