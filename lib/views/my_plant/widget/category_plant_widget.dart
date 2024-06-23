import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

class CategoryPlantWidget extends StatelessWidget {
  CategoryPlantWidget({super.key});

  final myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (myPlantController.categoryData.value) {
        case Status.loading:
          return SizedBox(
            height: 35,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount:
                    myPlantController.plantCategoriesResponse?.data.length,
                itemBuilder: (context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: ShimmerContainerGlobalWidget(
                        width: 75, height: 32, radius: 50),
                  );
                }),
          );
        case Status.loaded:
          if (myPlantController.plantCategoriesResponse!.data.isEmpty) {
            return SizedBox(
              height: 32,
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
              height: 35,
              width: double.infinity,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      myPlantController.plantCategoriesResponse?.data.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                              border: myPlantController.activeIndex.value ==
                                      index
                                  ? Border.all(color: ColorConstant.primary500)
                                  : Border.all(
                                      color: ColorConstant.neutral300,
                                    ),
                              color:
                                  index == myPlantController.activeIndex.value
                                      ? ColorConstant.primary100
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(
                                50,
                              )),
                          child: InkWell(
                            onTap: () {
                              if (myPlantController.activeIndex.value ==
                                  index) {
                                myPlantController.getRecommendationPlant();
                                myPlantController.currentIndex(-1);
                              } else {
                                myPlantController.currentIndex(index);
                              }
                              if (myPlantController.plantCategoriesResponse
                                      ?.data[index].id !=
                                  null) {
                                myPlantController.getPlantByCatergories(
                                    myPlantController.plantCategoriesResponse!
                                        .data[index].id);
                              }
                            },
                            child: Center(
                              child: Text(
                                myPlantController.plantCategoriesResponse
                                        ?.data[index].name ??
                                    "-",
                                style:
                                    index == myPlantController.activeIndex.value
                                        ? TextStyleConstant.paragraph.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.primary500,
                                          )
                                        : TextStyleConstant.paragraph,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
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