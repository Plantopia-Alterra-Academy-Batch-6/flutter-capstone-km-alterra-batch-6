import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class NoResultGlobalWidget extends StatelessWidget {
  const NoResultGlobalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 94),
          SizedBox(
            width: 212,
            height: 156,
            child: SvgPicture.asset('assets/icons/empty_history_plant.svg'),
          ),
          const SizedBox(height: 40),
          Text(
            "No Result",
            style: TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            "Sorry, there are no results for this search.",
            style: TextStyleConstant.paragraph,
          ),
          Text(
            "Please try another result.",
            style: TextStyleConstant.paragraph,
          ),
        ],
      ),
    );
  }
}
