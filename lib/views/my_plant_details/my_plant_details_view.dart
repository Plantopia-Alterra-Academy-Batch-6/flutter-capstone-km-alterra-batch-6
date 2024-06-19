import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/my_plant_details/widget/about_plant_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/bottom_sheet_delete_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/faq_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/image_carousel_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/monitoring_progress_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_care_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_characteristics_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_guide_card_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_history_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_requirements_widget.dart';

class MyPlantDetailsView extends StatelessWidget {
  MyPlantDetailsView({super.key});

  final ValueNotifier<bool> isBottomBarVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Plant Details",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.wateringHistory);
            },
            icon: SvgPicture.asset(
              IconConstant.history,
            ),
          )
        ],
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
          child: Column(
            children: [
              ImageCarouselWidget(),
              Transform.translate(
                offset: const Offset(0, -30),
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
                        PlantHistoryWidget(),
                        const PlantRequirementsWidget(),
                        const PlantCharacteristicsWidget(),
                        const PlantGuideCardWidget(),
                        MonitoringProgressWidget(),
                        PlantCareWidget(),
                        FaqWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.chatbot);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant
                                    .primary500, // Button background color
                                fixedSize: const Size(
                                    double.infinity, 60), // Button size
                                padding: const EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: SvgPicture.asset(
                                IconConstant.chat,
                              )),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {
                              if (detailMyPlant.id != null) {
                                Get.bottomSheet(BottomSheetDeleteWidget(
                                  plantId: detailMyPlant.id!,
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant
                                  .primary500, // Button background color
                              fixedSize: const Size(
                                  double.infinity, 60), // Button size
                              padding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Customize Plant',
                              style: TextStyleConstant.subtitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
