import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class DottedBorderImageWidget extends StatelessWidget {
  const DottedBorderImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ColorConstant.neutral300,
      radius: const Radius.circular(6),
      borderType: BorderType.RRect,
      strokeWidth: 1.2,
      dashPattern: const [11],
      child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/upload_photo.svg"),
                const SizedBox(
                  height: 9.76,
                ),
                RichText(
                  text: const TextSpan(
                    text: 'Upload Your First Plant Image',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
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
