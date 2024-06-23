import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/utils/app_routes.dart';

class CustomTextButtonForgotPasswordWidget extends StatelessWidget {
  const CustomTextButtonForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.forgotPassword);
        },
        child: Text(
          "Forgot password?",
          style: TextStyleConstant.paragraph
              .copyWith(color: ColorConstant.link500),
        ));
  }
}
