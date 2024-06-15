import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/upload_progress/widget/dotted_border_image_widget.dart';

class MonitoringProgressWidget extends StatelessWidget {
  const MonitoringProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "Monitoring Plant Progress",
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.uploadProgress,
                arguments: {'id': detailMyPlant.plant?.id});
          },
          child: const DottedBorderImageWidget(
            height: 180,
          ),
        ),
      ],
    );
  }
}
