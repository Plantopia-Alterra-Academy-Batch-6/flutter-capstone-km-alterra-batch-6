import 'package:get/get.dart';
import 'package:plantopia/controllers/plant_filter_controller.dart';
import 'package:plantopia/models/get_plant_filter_search_result_response.dart';
import 'package:plantopia/service/plant_filter_search_result_service.dart';

class PlantFilterSearchResultController extends GetxController {
  RxBool isPageLoading = false.obs;
  RxBool isHaveResult = false.obs;

  PlantFilterSearchResultService plantFilterSearchResultService =
      PlantFilterSearchResultService();
  final plantFilterController = Get.put(PlantFilterController());
  PlantFilterSearchResultResponse? searchedPlantResponse;

  Future<void> updateQuery(String newCategoryIndex) async {
    isPageLoading(true);
    try {
      if (newCategoryIndex.isEmpty) {
        plantFilterController.queryParams.value =
            plantFilterController.queryParams.value
                .replaceAll(
                  RegExp(r'plant_category=[^&]*'),
                  '',
                )
                .replaceAll(
                  RegExp(r'&+'), // Remove any extraneous '&' characters
                  '&',
                )
                .replaceAll(
                  RegExp(r'^&|&$'), // Remove leading or trailing '&' characters
                  '',
                );
      } else {
        if (plantFilterController.queryParams.value
            .contains('plant_category=')) {
          plantFilterController.queryParams.value =
              plantFilterController.queryParams.value.replaceAll(
            RegExp(r'plant_category=[^&]*'),
            'plant_category=$newCategoryIndex',
          );
        } else {
          if (plantFilterController.queryParams.value.isEmpty) {
            plantFilterController.queryParams.value =
                'plant_category=$newCategoryIndex';
          } else {
            plantFilterController.queryParams.value +=
                '&plant_category=$newCategoryIndex';
          }
        }
      }

      searchedPlantResponse = await plantFilterSearchResultService.searchPlantByFilter(plantFilterController.queryParams.value);

      if (searchedPlantResponse!.message! != "No data found") {
        isHaveResult(true);
      } else {
        isHaveResult(false);
      }

    } on Exception {
      isHaveResult(false); // Set false if an error occurs
    } finally {
      isPageLoading(false);
    }
  }
}
