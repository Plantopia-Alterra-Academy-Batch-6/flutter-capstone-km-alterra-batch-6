import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/my_plant/widget/empty_my_plant_widget.dart';

class MyPlantListWidget extends StatelessWidget {
  MyPlantListWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Obx(() {
          switch (myPlantController.myPlantData.value) {
            case Status.loading:
              return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2),
                  itemBuilder: (context, int index) {
                    return const ShimmerContainerGlobalWidget(
                      width: 156,
                      height: 200,
                      radius: 24,
                    );
                  });
            case Status.loaded:
              if (myPlantController.listMyPlant.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: EmptyMyPlantWidget(),
                );
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myPlantController.listMyPlant.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2),
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.myPlantDetails, arguments: {
                          'myPlantDetails': myPlantController.listMyPlant[index]
                        })?.then((value) {
                          myPlantController.getMyPlant();
                        });
                      },
                      child: CardGlobalWidget(
                        plantName:
                            myPlantController.listMyPlant[index].plant?.name ??
                                "",
                        plantCategory: myPlantController.listMyPlant[index]
                                .plant?.plantCategory?.name ??
                            "",
                        plantImageUrl: myPlantController.listMyPlant[index]
                                .plant?.plantImages?[0].fileName ??
                            "",
                      ),
                    );
                  },
                );
              }
            case Status.error:
              return Center(
                child: Text(
                  "Failed to load my plant data",
                  style: TextStyleConstant.heading4.copyWith(
                    color: ColorConstant.danger500,
                  ),
                ),
              );
            default:
              return const EmptyMyPlantWidget();
          }
        }),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
