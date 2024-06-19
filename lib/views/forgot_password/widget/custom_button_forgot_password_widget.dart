import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomButtonForgotPasswordWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? borderRadiusCircular;
  final bool isActive;
  final bool isLoading;

  const CustomButtonForgotPasswordWidget({
    super.key,
    this.onPressed,
    required this.text,
    this.borderRadiusCircular,
    this.isActive = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusCircular ?? 8),
              ),
              elevation: 0,
              backgroundColor: isActive
                  ? ColorConstant.primary500
                  : ColorConstant.neutral100),
          onPressed: isActive && !isLoading ? onPressed : () {},
          child: isLoading
              ? CircularProgressIndicator(
                  color: ColorConstant.white,
                )
              : Text(text,
                  style: TextStyleConstant.subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isActive
                          ? ColorConstant.white
                          : ColorConstant.neutral400)),
        ));
  }
}
