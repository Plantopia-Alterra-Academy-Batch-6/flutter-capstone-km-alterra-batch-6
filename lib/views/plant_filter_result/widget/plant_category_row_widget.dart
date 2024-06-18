import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_controller.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';
import 'package:plantopia/controllers/search_plant_filter_controller.dart';

class PlantCategoryRowWidget extends StatelessWidget {
  PlantCategoryRowWidget({super.key}) {
    // Initialize the controllers
    final addPlantController = Get.put(AddPlantController());
    final plantFilterController = Get.put(PlantFilterController());

    // Set the default selected category to the first one if not already selected
    if (addPlantController.plantCategoriesResponse != null &&
        addPlantController.plantCategoriesResponse!.data.isNotEmpty &&
        !plantFilterController.isPlantCategorySelected.value) {
      plantFilterController.selectedCategory.value = plantFilterController.selectedCategory.value;
      plantFilterController.isPlantCategorySelected.value = true;
    }
  }

  final addPlantController = Get.put(AddPlantController());
  final plantFilterController = Get.put(PlantFilterController());
  final plantFilterSearchResultController = Get.put(PlantFilterSearchResultController());
  final searchPlantFilterController = Get.put(SearchPlantFilterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                addPlantController.plantCategoriesResponse!.data.length,
                (int index) {
                  bool isSelected = plantFilterController.isPlantCategorySelected.value && plantFilterController.selectedCategory.value == addPlantController.plantCategoriesResponse!.data[index].id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          plantFilterController.isPlantCategorySelected.value = false;
                          plantFilterController.selectedCategory.value = -1; // Reset selection

                          plantFilterSearchResultController.updateQuery('');
                          searchPlantFilterController.isPlantFound(false);
                        } else {
                          plantFilterController.selectedCategory.value = addPlantController
                              .plantCategoriesResponse!.data[index].id;
                          plantFilterController.isPlantCategorySelected.value = true;

                          plantFilterSearchResultController.updateQuery(
                            plantFilterController.selectedCategory.value.toString(),
                          );
                          searchPlantFilterController.isPlantFound(false);
                        }
                      },
                      child: IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorConstant.primary100
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? ColorConstant.primary500
                                  : ColorConstant.neutral300,
                            ),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Text(
                            addPlantController
                                .plantCategoriesResponse!.data[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyleConstant.paragraph.copyWith(
                              color: isSelected
                                  ? ColorConstant.primary500
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
