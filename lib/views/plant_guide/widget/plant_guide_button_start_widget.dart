import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class PlantGuideButtonStartWidget extends StatelessWidget {
  final void Function() onPressed;
  const PlantGuideButtonStartWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.primary500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(
            'Start Planting',
            style: TextStyleConstant.subtitle.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorConstant.white,
            ),
          ),
        ),
      ),
    );
  }
}
