import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class EmptyAllPhotosWidget extends StatelessWidget {
  const EmptyAllPhotosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            "You haven't added any photos yet. ",
            style: TextStyleConstant.paragraph.copyWith(
              fontSize: 14.0,
              color: ColorConstant.neutral400,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            " Upload your first plant photo and watch your ",
            style: TextStyleConstant.paragraph.copyWith(
              fontSize: 14.0,
              color: ColorConstant.neutral400,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            "garden grow! 🪴 ",
            style: TextStyleConstant.paragraph.copyWith(
              fontSize: 14.0,
              color: ColorConstant.neutral400,
            ),
          ),
        ],
      ),
    );
  }
}
