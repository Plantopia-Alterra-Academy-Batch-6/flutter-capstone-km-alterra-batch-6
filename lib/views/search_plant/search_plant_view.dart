import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/search_plant_controller.dart';
import 'package:plantopia/views/add_plant/widget/plant_category.dart';
import 'package:plantopia/views/global_widgets/no_result_global_widget.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/search_plant/widget/search_bar.dart';
import 'package:get/get.dart';
import 'package:plantopia/views/search_plant/widget/search_plant_result.dart';

class SearchPlantView extends StatelessWidget {
  SearchPlantView({super.key});

  final controller = Get.put(SearchPlantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Search Plant",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(),
              const SizedBox(height: 26),
              Obx(
                () {
                  if (controller.isPageLoading.isTrue) {
                    return const ShimmerContainerGlobalWidget(
                      width: 156,
                      height: 200,
                      radius: 30,
                    );
                  }
                  if (controller.isFirstTimeOpen.isTrue) {
                    return PlantCategoryWidget();
                  }
                  if (controller.isHaveResult.isTrue) {
                    return SearchPlantResultWidget();
                  } else {
                    return const NoResultGlobalWidget();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
