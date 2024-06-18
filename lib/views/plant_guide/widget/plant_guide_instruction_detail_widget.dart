import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PlantGuideInstructionDetailWidget extends StatelessWidget {
  final String categoryTitle;
  final String categoryDescription;
  final int stepNumber;
  final String stepTitle;
  final String stepDescription;
  final String imageUrl;

  const PlantGuideInstructionDetailWidget({
    super.key,
    required this.categoryTitle,
    required this.categoryDescription,
    required this.stepNumber,
    required this.stepTitle,
    required this.stepDescription,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryTitle,
          style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          categoryDescription,
          style: TextStyleConstant.paragraph,
        ),
        const SizedBox(height: 16),
        buildStep(
          stepNumber: stepNumber,
          stepTitle: stepTitle,
          stepDescription: stepDescription,
          imageUrl: imageUrl,
        ),
      ],
    );
  }

  Widget buildStep({
    required int stepNumber,
    required String stepTitle,
    required String stepDescription,
    required String imageUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $stepNumber',
          style: TextStyleConstant.paragraph
              .copyWith(color: ColorConstant.neutral500),
        ),
        const SizedBox(height: 4),
        Text(
          stepTitle,
          style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
          overflow: TextOverflow.clip,
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl),
        ),
        const SizedBox(height: 14),
        HtmlWidget(
          stepDescription,
          textStyle: TextStyle(color: ColorConstant.neutral900, fontSize: 16.0),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
