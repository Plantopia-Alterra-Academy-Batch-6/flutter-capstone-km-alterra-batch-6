import 'package:flutter/material.dart';
import 'package:plantopia/views/my_plant/widget/category_plant_widget.dart';
import 'package:plantopia/views/my_plant/widget/list_recomended_plant_widget.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryPlantWidget(),
        const SizedBox(
          height: 18,
        ),
        ListRecomendedPlantWidget(),
      ],
    );
  }
}