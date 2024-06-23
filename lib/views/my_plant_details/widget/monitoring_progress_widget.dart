import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/upload_progress/widget/dotted_border_image_widget.dart';

class MonitoringProgressWidget extends StatelessWidget {
  MonitoringProgressWidget({
    super.key,
  });

  final controller = Get.put(MyPlantDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    controller.getPlantProgress(detailMyPlant.plant?.id ?? -1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Monitoring Plant Progress",
              style: TextStyleConstant.heading4.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.uploadProgress,
                    arguments: {'id': detailMyPlant.plant?.id})?.then(
                  (value) async {
                    await controller
                        .getPlantProgress(detailMyPlant.plant?.id ?? -1);
                  },
                );
              },
              child: Text(
                "View more",
                style: TextStyleConstant.paragraph.copyWith(
                  color: ColorConstant.link500,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(
          () => controller.progressPlant.isEmpty
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.uploadProgress,
                        arguments: {'id': detailMyPlant.plant?.id})?.then(
                      (value) async {
                        await controller
                            .getPlantProgress(detailMyPlant.plant?.id ?? -1);
                      },
                    );
                  },
                  child: const DottedBorderImageWidget(
                    height: 180,
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.progressPlant.length > 4
                          ? 4
                          : controller.progressPlant.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    controller.progressPlant[index].imageUrl ??
                                        "",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            width: 70,
                            height: 64,
                          ),
                        );
                      }),
                ),
        )
      ],
    );
  }
}
