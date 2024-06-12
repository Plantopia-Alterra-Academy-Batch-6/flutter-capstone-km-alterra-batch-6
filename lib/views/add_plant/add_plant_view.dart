import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/views/add_plant/widget/plant_category.dart';
import 'package:plantopia/views/add_plant/widget/recommended_card.dart';
import 'package:plantopia/views/add_plant/widget/search_bar.dart';
import 'package:get/get.dart';

class AddPlantView extends StatelessWidget {
  AddPlantView({super.key});

  final controller = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isPageLoading.value) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              title: Text(
                "Add Plants",
                style: TextStyleConstant.heading4
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              title: Text(
                "Add Plants",
                style: TextStyleConstant.heading4
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchBarWidget(),
                    const SizedBox(height: 28),
                    const RecommendedCardWidget(),
                    const SizedBox(height: 32),
                    PlantCategoryWidget(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
