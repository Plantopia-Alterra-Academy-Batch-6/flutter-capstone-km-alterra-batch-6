import 'package:dio/dio.dart';
import 'package:plantopia/models/get_search_plant_response.dart';
import 'package:plantopia/utils/base_url_util.dart';

class SearchPlantService {
  Dio dio = Dio();

  Future<SearchedPlantResponse> searchPlantByName(String plantName) async {
    final api =
        "${BaseUrlUtil.baseUrl}/plants/search?name=$plantName";
    final response = await dio.get(api);

    if (response.statusCode == 200) {
      return SearchedPlantResponse.fromJson(response.data);
    } else {
      throw Exception(
          "Failed to get search plant by name: ${response.statusCode}");
    }
  }
}
