import 'package:dio/dio.dart';
import 'package:plantopia/models/get_search_plant_response.dart';

class SearchPlantService {
  Dio dio = Dio();

  Future<SearchedPlantResponse> searchPlantByName(String plantName) async {
    final api =
        "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/search?name=$plantName";
    final response = await dio.get(api);

    if (response.statusCode == 200) {
      return SearchedPlantResponse.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to get search plant by name: ${response.statusCode}");
    }
  }
}
