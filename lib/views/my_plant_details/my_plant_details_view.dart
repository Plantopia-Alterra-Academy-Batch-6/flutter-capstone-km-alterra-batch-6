import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/my_plant_details/widget/about_plant_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/faq_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/image_carousel_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/monitoring_progress_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_care_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_characteristics_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_guide_card_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_history_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_requirements_widget.dart';

class MyPlantDetailsView extends StatelessWidget {
  const MyPlantDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: SvgPicture.asset(
              IconConstant.history,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Column(
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
                          const MonitoringProgressWidget(),
                          const PlantCareWidget(),
                          FaqWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ColorConstant.primary500, // Button background color
                    fixedSize: const Size(double.infinity, 60), // Button size
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ColorConstant.primary500, // Button background color
                  fixedSize: const Size(double.infinity, 60), // Button size
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
      ),
    );
  }
}
