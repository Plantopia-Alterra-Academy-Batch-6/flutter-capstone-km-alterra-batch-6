import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';
import 'package:plantopia/controllers/plant_history_controller.dart';
import 'package:plantopia/views/global_widgets/center_circular_progress_global_widget.dart';
import 'package:plantopia/views/global_widgets/center_error_message_global_widget.dart';
import 'package:plantopia/views/plant_details/widget/about_plant_widget.dart';
import 'package:plantopia/views/plant_details/widget/faq_widget.dart';
import 'package:plantopia/views/plant_details/widget/image_carousel_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_care_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_characteristics_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_guide_card_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_requirements_widget.dart';

class PlantDetailsView extends StatelessWidget {
  PlantDetailsView({super.key});

  final controller = Get.put(PlantDetailsController());
  final PlantHistoryController plantHistoryController =
      Get.put(PlantHistoryController());
  final addPlantController = Get.put(AddPlantController());

  final ValueNotifier<bool> isBottomBarVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Plant Details",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              isBottomBarVisible.value = true;
            } else if (scrollNotification.scrollDelta! > 0) {
              isBottomBarVisible.value = false;
            } else if (scrollNotification.scrollDelta! < 0) {
              isBottomBarVisible.value = true;
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Obx(
            () {
              if (controller.isPageLoading.isTrue) {
                return const CenterCircularProgressGlobalWidget();
              }
              if (controller.isDataError.isTrue) {
                return const CenterErrorMessageGlobalWidget(
                    pageName: "Plant Details");
              } else {
                return Column(
                  children: [
                    ImageCarouselWidget(),
                    Transform.translate(
                      offset: const Offset(
                          0, -30), // Moves the container up by 20 pixels
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AboutPlantWidget(),
                              PlantRequirementsWidget(),
                              PlantCharacteristicsWidget(),
                              PlantGuideCardWidget(),
                              PlantCareWidget(),
                              FaqWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: isBottomBarVisible,
        builder: (context, isVisible, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isVisible
                ? 76.0
                : 0.0, // Ensure the height is appropriate for visibility
            child: isVisible
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller
                            .addPlant(addPlantController.selectedPlant.value);
                        await plantHistoryController.addPlantingHistory(
                            controller.plantByIdResponse?.data?.id ?? -1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ColorConstant.primary500, // Button background color
                        fixedSize:
                            const Size(double.infinity, 60), // Button size
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Add to my plants',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Button text color
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
