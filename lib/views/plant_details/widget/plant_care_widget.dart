import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';

class PlantCareWidget extends StatelessWidget {
  PlantCareWidget({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Plant Care",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        HtmlWidget(controller.plantByIdResponse?.data?.additionalTips ?? "-")
      ],
    );
  }
}
