import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomUploadProgressButtonWidget extends StatelessWidget {
  final bool isActive;
  final bool isLoading;
  final void Function()? onPressed;
  const CustomUploadProgressButtonWidget({
    super.key,
    this.isActive = false,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor:
                isActive ? ColorConstant.primary500 : ColorConstant.neutral100,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? CircularProgressIndicator(
                color: ColorConstant.white,
              )
            : Text(
                "Save",
                style: TextStyleConstant.subtitle.copyWith(
                    color: isActive
                        ? ColorConstant.white
                        : ColorConstant.neutral400),
              ),
      ),
    );
  }
}
