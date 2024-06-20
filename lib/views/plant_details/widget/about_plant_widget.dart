import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';

class AboutPlantWidget extends StatelessWidget {
  AboutPlantWidget({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20), // Add some space to adjust for the overlap
        Center(
          child: Text(
            controller.extractPlantName(controller.plantByIdResponse!.data!.name!),
            style: TextStyleConstant.heading3
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          controller.filterHtmlTag(controller.plantByIdResponse!.data!.description!),
          style: TextStyleConstant.paragraph,
        ),
      ],
    );
  }
}
