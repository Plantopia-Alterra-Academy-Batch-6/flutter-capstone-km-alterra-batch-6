import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class ErrorSizePhotoWidget extends StatelessWidget {
  const ErrorSizePhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/error-image.svg"),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          textAlign: TextAlign.center,
          "Your photo is too large! It must be under 2 MB. ",
          style: TextStyleConstant.paragraph.copyWith(
            fontSize: 14.0,
            color: ColorConstant.danger500,
          ),
        ),
      ],
    );
  }
}
