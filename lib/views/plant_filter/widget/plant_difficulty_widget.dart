import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_filter_controller.dart';

class PlantDifficultyWidget extends StatelessWidget {
  PlantDifficultyWidget({super.key});

  final plantFilterController = Get.put(PlantFilterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Difficulty Level",
          style:
              TextStyleConstant.subtitle.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            children: List.generate(
              3,
              (int index) {
                bool isSelected =
                    plantFilterController.isDifficultyLevelSelected.value &&
                        plantFilterController.selectedDifficultyLevel.value ==
                            index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        plantFilterController.isDifficultyLevelSelected.value =
                            false;
                        plantFilterController.selectedDifficultyLevel.value =
                            -1; 
                      } else {
                        plantFilterController.selectedDifficultyLevel.value =
                            index;
                        plantFilterController.isDifficultyLevelSelected.value =
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
                          plantFilterController.difficultyLevel[index],
                          textAlign: TextAlign.center,
                          style: TextStyleConstant.paragraph.copyWith(
                            color: isSelected
                                ? ColorConstant.primary500
                                : ColorConstant.neutral950,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
