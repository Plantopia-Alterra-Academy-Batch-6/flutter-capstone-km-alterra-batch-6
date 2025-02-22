import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_controller.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/plant_filter/widget/plant_category_widget.dart';
import 'package:plantopia/views/plant_filter/widget/plant_harvest_duration_widget.dart';
import 'package:plantopia/views/plant_filter/widget/plant_sunlight_req_widget.dart';
import 'package:plantopia/views/plant_filter/widget/plant_toxicity_widget.dart';

class PlantFilterView extends StatelessWidget {
  PlantFilterView({super.key});

  final addPlantController = Get.put(AddPlantController());
  final plantFilterSearchResultController =
      Get.put(PlantFilterSearchResultController());
  final controller = Get.put(PlantFilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Plant Filter",
              style: TextStyleConstant.heading4
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            IconButton(
              icon:  Icon(Icons.close, color: ColorConstant.neutral950),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantCategoryWidget(),
              const SizedBox(height: 32),
              PlantSunlightReqWidget(),
              const SizedBox(height: 32),
              PlantHarvestDurationWidget(),
              const SizedBox(height: 32),
              PlantToxicityWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 76,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              String plantCategory;
              if (controller.selectedCategory.value == 0) {
                plantCategory = '';
              } else {
                plantCategory = controller.selectedCategory.value.toString();
              }
              await controller.createQueryParams();
              plantFilterSearchResultController.updateQuery(plantCategory);

              if (kDebugMode) {
                print(addPlantController.isFilterSearchResulted.value);
              }
              if (addPlantController.isFilterSearchResulted.isTrue) {
                if (!context.mounted) return;
                Navigator.pop(context);
                if (kDebugMode) {
                  print("true");
                }
              } else {
                if (kDebugMode) {
                  print("false");
                }
                addPlantController.isFilterSearchResulted(true);
                Get.offNamed(AppRoutes.plantFilterResult);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primary500,
              fixedSize: const Size(double.infinity, 60),
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child:  Text(
              'Show result',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstant.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
