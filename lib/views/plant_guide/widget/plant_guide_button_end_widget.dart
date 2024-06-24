import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';
import 'package:plantopia/controllers/plant_history_controller.dart';
import 'package:plantopia/utils/app_routes.dart';

class PlantGuideButtonEndWidget extends StatelessWidget {
  final String? textButton;
  const PlantGuideButtonEndWidget({super.key, this.textButton});

  @override
  Widget build(BuildContext context) {
    final addPlantController = Get.find<AddPlantController>();
    final plantDetailsController = Get.find<PlantDetailsController>();
    final plantHistoryController = Get.put(PlantHistoryController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.primary500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          onPressed: () {
            if (textButton == 'Finished') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: ColorConstant.white,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          ImageConstant.confirmation,
                        ),
                        Text(
                          "Are you sure you finished your planting?",
                          textAlign: TextAlign.center,
                          style: TextStyleConstant.heading4.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Plants will be added to my plants",
                          textAlign: TextAlign.center,
                          style: TextStyleConstant.paragraph.copyWith(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyleConstant.subtitle.copyWith(
                                  color: ColorConstant.danger500,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primary500,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () async {
                                await plantDetailsController.addPlant(
                                    addPlantController.selectedPlant.value);
                                await plantHistoryController.addPlantingHistory(
                                    addPlantController.selectedPlant.value);
                                Get.toNamed(AppRoutes.successAddPlant);
                              },
                              child: Text(
                                "Finished",
                                style: TextStyleConstant.subtitle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              Get.back();
            }
          },
          child: Text(
            textButton ?? 'Finished',
            style: TextStyleConstant.subtitle.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorConstant.white,
            ),
          ),
        ),
      ),
    );
  }
}
