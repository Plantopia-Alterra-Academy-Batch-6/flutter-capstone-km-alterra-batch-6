import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class MonitoringProgressWidget extends StatelessWidget {
  const MonitoringProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "Monitoring Plant Progress",
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8,
            ),
            border: Border.all(
              width: 1,
              color: ColorConstant.neutral300,
            ),
          ),
          width: double.infinity,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconConstant.addPhoto,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Upload Your First Plant Image*\n(max. 2 MB)",
                style: TextStyleConstant.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
