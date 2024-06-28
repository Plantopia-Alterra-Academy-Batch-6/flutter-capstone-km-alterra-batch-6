import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class DottedBorderImageWidget extends StatelessWidget {
  const DottedBorderImageWidget({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ColorConstant.neutral300,
      radius: const Radius.circular(6),
      borderType: BorderType.RRect,
      strokeWidth: 1.2,
      dashPattern: const [11],
      child: SizedBox(
          height: height ?? 300,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(IconConstant.addPhoto),
                const SizedBox(
                  height: 9.76,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Upload Your First Plant Image',
                    style: TextStyleConstant.caption.copyWith(
                      color: ColorConstant.neutral500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '*',
                          style: TextStyleConstant.caption
                              .copyWith(color: ColorConstant.danger500)),
                    ],
                  ),
                ),
                Text(
                  "(max. 2 MB)",
                  style: TextStyleConstant.caption
                      .copyWith(color: ColorConstant.neutral500, fontSize: 12),
                )
              ],
            ),
          )),
    );
  }
}
