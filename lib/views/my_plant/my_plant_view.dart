import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/recommended_widget.dart';
import 'package:plantopia/views/my_plant/widget/my_plant_list_widget.dart';
import 'package:plantopia/views/my_plant/widget/search_bar_widget.dart';
import 'package:plantopia/views/my_plant/widget/single_result_widget.dart';

class MyPlantView extends StatelessWidget {
  MyPlantView({super.key}) {
    Get.lazyPut<MyPlantController>(() => MyPlantController());
  }

  @override
  Widget build(BuildContext context) {
    final MyPlantController myPlantController = Get.find<MyPlantController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: myPlantController.scrollController,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    "My Plant",
                    style: TextStyleConstant.heading3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Obx(
                    () => Text(
                      '${myPlantController.listMyPlant.length} Plants',
                      style: TextStyleConstant.subtitle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SearchBarWidget(),
                ),
                Obx(
                  () {
                    if (myPlantController.isSearchFound.isTrue &&
                        myPlantController.searchController.text != "") {
                      return SingleResultWidget();
                    } else {
                      return MyPlantListWidget();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const RecommendedWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => myPlantController.showFloatingButton.value
            ? FloatingActionButton.extended(
                onPressed: () {
                  Get.toNamed(AppRoutes.addPlant);
                },
                backgroundColor: ColorConstant.primary500,
                label: Text(
                  'Add Plant',
                  style: TextStyleConstant.subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
              )
            : FloatingActionButton(
                backgroundColor: ColorConstant.primary500,
                onPressed: () {
                  Get.toNamed(AppRoutes.addPlant);
                },
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}