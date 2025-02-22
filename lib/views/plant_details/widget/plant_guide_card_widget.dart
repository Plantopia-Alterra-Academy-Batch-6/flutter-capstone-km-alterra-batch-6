import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';

class PlantGuideCardWidget extends StatelessWidget {
  PlantGuideCardWidget({super.key});

  final addPlantController = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.plantGuide, arguments: {
              'plantId': addPlantController.selectedPlant.value,
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                border: Border.all(
                  width: 1,
                  color: ColorConstant.neutral400,
                )),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 13, 22, 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/plant_guide.png',
                  width: 87,
                  height: 91,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Planting Guide",
                        style: TextStyleConstant.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Find a complete guide to planting and caring for your plants perfectly.",
                        style: TextStyleConstant.paragraph.copyWith(
                          color: ColorConstant.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
