import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class PlantGuideInstructionCategoryWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? color;

  const PlantGuideInstructionCategoryWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = textStyle ??
        TextStyleConstant.subtitle
            .copyWith(fontSize: 16, fontWeight: FontWeight.w700);

    return Container(
      width: 328,
      height: 69,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: defaultTextStyle,
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}