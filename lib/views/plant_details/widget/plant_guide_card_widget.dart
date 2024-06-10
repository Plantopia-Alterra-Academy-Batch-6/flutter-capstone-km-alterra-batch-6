import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class PlantGuideCardWidget extends StatelessWidget {
  const PlantGuideCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        InkWell(
          onTap: () {
            //TODO: go to plant guide page
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                border: Border.all(
                  width: 1,
                  color: ColorConstant.neutral400,
                )),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 13, 22, 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/icons/plant_guide.svg',
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Planting Guide",
                        style: TextStyleConstant.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Find a complete guide to planting and caring for your plants perfectly.",
                        style: TextStyleConstant.paragraph.copyWith(
                          color: ColorConstant.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
