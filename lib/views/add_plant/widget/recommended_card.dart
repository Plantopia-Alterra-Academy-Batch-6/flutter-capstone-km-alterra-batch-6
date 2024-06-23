import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class RecommendedCardWidget extends StatelessWidget {
  RecommendedCardWidget({super.key});

  final controller = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended",
          style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.plantRecommendationsResponse!.data!.length,
            itemExtent: 156,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    controller.selectedPlant(controller
                        .plantRecommendationsResponse!.data![index].id);
                    Get.toNamed(AppRoutes.plantDetails);
                  },
                  child: CardGlobalWidget(
                    plantName: controller.extractPlantName(controller
                        .plantRecommendationsResponse!.data![index].name!),
                    plantCategory: controller.extractFamilyName(controller
                        .plantRecommendationsResponse!.data![index].name!),
                    plantImageUrl: controller.plantRecommendationsResponse
                                    ?.data?[index].plantImages !=
                                null &&
                            controller.plantRecommendationsResponse!
                                .data![index].plantImages!.isNotEmpty
                        ? controller.plantRecommendationsResponse!.data![index]
                                .plantImages![0].fileName ??
                            ""
                        : "",
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
