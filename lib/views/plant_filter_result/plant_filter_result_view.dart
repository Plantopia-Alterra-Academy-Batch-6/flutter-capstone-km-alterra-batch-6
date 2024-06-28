import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';
import 'package:plantopia/controllers/search_plant_filter_controller.dart';
import 'package:plantopia/views/global_widgets/no_result_global_widget.dart';
import 'package:plantopia/views/plant_filter_result/widget/plant_category_row_widget.dart';
import 'package:plantopia/views/plant_filter_result/widget/plant_filter_result_bar_widget.dart';
import 'package:plantopia/views/plant_filter_result/widget/plant_filter_result_skeleton_widget.dart';
import 'package:plantopia/views/plant_filter_result/widget/plant_filter_single_result_widget.dart';
import 'package:plantopia/views/plant_filter_result/widget/plant_filter_result_widget.dart';

class PlantFilterResultView extends StatelessWidget {
  PlantFilterResultView({super.key});

  final controller = Get.put(PlantFilterSearchResultController());
  final searchPlantFilterController = Get.put(SearchPlantFilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Search Result",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlantFilterResultBarWidget(),
            const SizedBox(height: 20),
            PlantCategoryRowWidget(),
            const SizedBox(height: 12),
            Obx(
              () {
                if (controller.isPageLoading.isTrue) {
                  return const PlantFilterResultSkeletonWidget();
                }
                if (searchPlantFilterController.isPlantFound.isTrue) {
                  return PlantFilterSingleResultWidget();
                }
                if (controller.isHaveResult.isTrue) {
                  return PlantFilterResultWidget();
                } else {
                  return const NoResultGlobalWidget();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
