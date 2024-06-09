import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/my_plant/widget/category_plant_widget.dart';
import 'package:plantopia/views/my_plant/widget/list_recomended_plant_widget.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended',
              style: TextStyleConstant.heading4.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View More",
                style: TextStyleConstant.paragraph.copyWith(
                  color: ColorConstant.link500,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const CategoryPlantWidget(),
        const SizedBox(
          height: 18,
        ),
        const ListRecomendedPlantWidget(),
      ],
    );
  }
}
