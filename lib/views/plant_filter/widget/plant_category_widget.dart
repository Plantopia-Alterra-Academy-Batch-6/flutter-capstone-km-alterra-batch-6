import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_controller.dart';

class PlantCategoryWidget extends StatelessWidget {
  PlantCategoryWidget({super.key});

  final addPlantController = Get.put(AddPlantController());
  final plantFilterController = Get.put(PlantFilterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Plant Category",
          style:
              TextStyleConstant.subtitle.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            children: List.generate(
              addPlantController.plantCategoriesResponse!.data.length,
              (int index) {
                bool isSelected =
                    plantFilterController.isPlantCategorySelected.value &&
                        plantFilterController.selectedCategory.value ==
                            addPlantController
                                .plantCategoriesResponse!.data[index].id;
                return Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        plantFilterController.isPlantCategorySelected.value =
                            false;
                        plantFilterController.selectedCategory.value =
                            -1; 
                      } else {
                        plantFilterController.selectedCategory.value =
                            addPlantController
                                .plantCategoriesResponse!.data[index].id;
                        plantFilterController.isPlantCategorySelected.value =
                            true;
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
                              : ColorConstant.white,
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
                                : ColorConstant.danger950,
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
      ],
    );
  }
}
