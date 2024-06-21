import 'package:dio/dio.dart';
import 'package:plantopia/models/get_my_plant_response_model_new.dart';
import 'package:plantopia/utils/base_url_util.dart';

class GetMyPlantService {
  final Dio dio = Dio();

  Future<List<PlantInstruction>> getPlantInstructions() async {
    try {
      String url = BaseUrlUtil.plantGuide;
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        GetMyPlantResponseModelNew plantGuide =
            GetMyPlantResponseModelNew.fromJson(response.data);
        List<PlantInstruction> plantInstructions = [];
        if (plantGuide.data != null && plantGuide.data!.plants != null) {
          for (var plant in plantGuide.data!.plants!) {
            if (plant.plantInstructions != null) {
              plantInstructions.addAll(plant.plantInstructions!);
            }
          }
        }
        return plantInstructions;
      } else {
        throw Exception('Failed to load plant guide: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load plant guide: $e');
    }
  }
}
