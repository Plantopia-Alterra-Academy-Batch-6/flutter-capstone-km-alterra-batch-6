import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:plantopia/views/my_plant/widget/category_plant_widget.dart';
import 'package:plantopia/views/my_plant/widget/list_recomended_plant_widget.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: TextStyleConstant.heading4.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(

                onPressed: () {
                  Get.offAll(
                    const BottomNavigationBarGlobalWidget(
                      index: 2,
                    ),
                  );
                },
                child: Text(
                  "View More",
                  style: TextStyleConstant.paragraph.copyWith(
                    color: ColorConstant.link500,
                  ),
                ),
              )
            ],
          ),
        ),
        CategoryPlantWidget(),
        const SizedBox(
          height: 18,
        ),
        ListRecomendedPlantWidget(),
        const SizedBox(
                  height: 24,
                )
      ],
    );
  }
}
