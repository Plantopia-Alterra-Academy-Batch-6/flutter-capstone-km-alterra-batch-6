import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

class ListRecomendedPlantWidget extends StatelessWidget {
  ListRecomendedPlantWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());
  //final AddPlantController addPlantController = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (myPlantController.recommendationData.value) {
        case Status.loading:
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemExtent: 156,
                itemBuilder: (context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: ShimmerContainerGlobalWidget(
                        width: double.infinity, height: 200, radius: 24),
                  );
                }),
          );
        case Status.loaded:
          if (myPlantController.recommendationPlant.isEmpty) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(
                  "There is no recommendations for this category",
                  style: TextStyleConstant.paragraph,
                ),
              ),
            );
          } else {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: myPlantController.recommendationPlant.length,
                  itemExtent: 156,
                  itemBuilder: (context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            //addPlantController.selectedPlant.value =
                                myPlantController
                                    .recommendationPlant[index].id!;
                            Get.toNamed(AppRoutes.plantDetails);
                          },
                          child: CardGlobalWidget(
                              plantName: myPlantController
                                      .recommendationPlant[index].name ??
                                  "-",
                              plantCategory: myPlantController
                                      .recommendationPlant[index]
                                      .plantCategory
                                      ?.name ??
                                  "-",
                              plantImageUrl: myPlantController
                                      .recommendationPlant[index]
                                      .plantImages?[0]
                                      .fileName ??
                                  "-"),
                        ));
                  }),
            );
          }
        case Status.error:
          return Center(
            child: Text(
              "Failed to recommendations data",
              style: TextStyleConstant.heading4.copyWith(
                color: ColorConstant.danger500,
              ),
            ),
          );
        default:
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Text(
                "There is no recommendations for this category",
                style: TextStyleConstant.paragraph,
              ),
            ),
          );
      }
    });
  }
}
