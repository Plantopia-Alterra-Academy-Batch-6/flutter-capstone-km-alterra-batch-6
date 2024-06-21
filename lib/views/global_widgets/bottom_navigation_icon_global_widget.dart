import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/bottom_navigation_bar_controller.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class BottomNavigationIconWidget extends StatelessWidget {
  final String iconAssetPath;
  final String label;
  final int index;
  final BottomNavigationBarController controller;

  const BottomNavigationIconWidget({
    super.key,
    required this.iconAssetPath,
    required this.label,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = controller.currentIndex.value == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconAssetPath,
          height: 24,
          width: 24,
        ),
        Text(
          label,
          style: isSelected
              ? TextStyleConstant.subtitle.copyWith(
                  color: ColorConstant.primary500,
                  fontSize: 12,
                )
              : TextStyleConstant.caption.copyWith(
                  color: ColorConstant.neutral500,
                  fontSize: 12,
                ),
        ),
      ],
    );
  }
}
