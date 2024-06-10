import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class AboutPlantWidget extends StatelessWidget {
  AboutPlantWidget({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20), // Add some space to adjust for the overlap
        Center(
          child: Text(
            detailMyPlant.plant?.name ?? "-",
            style: TextStyleConstant.heading3
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          detailMyPlant.plant?.description ?? "-",
          style: TextStyleConstant.paragraph,
        ),
      ],
    );
  }
}
