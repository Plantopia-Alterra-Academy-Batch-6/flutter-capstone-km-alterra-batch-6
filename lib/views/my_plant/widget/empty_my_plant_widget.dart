import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyMyPlantWidget extends StatelessWidget {
  const EmptyMyPlantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstant.neutral300,
        ),
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          SvgPicture.asset(
            ImageConstant.g10,
            height: 58,
            width: 58,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Let’s get started by adding\nyour first plant!",
            textAlign: TextAlign.center,
            style: TextStyleConstant.paragraph,
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {},
            child: Ink(
              decoration: BoxDecoration(
                color: ColorConstant.primary100,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  14,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      IconConstant.add,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Add Plant",
                      style: TextStyleConstant.subtitle.copyWith(
                        color: ColorConstant.primary500,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
