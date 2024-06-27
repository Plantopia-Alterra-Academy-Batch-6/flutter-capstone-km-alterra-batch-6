import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomSnackbarProgressWidget {
  static void show(BuildContext context,
      {required void Function()? onPressed}) {
    final snackBar = SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "No photo added yet. Upload now?",
              style: TextStyleConstant.paragraph
                  .copyWith(color: ColorConstant.white),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                "Upload",
                style: TextStyleConstant.paragraph.copyWith(
                    color: ColorConstant.primary500,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width / 1.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static   void alertsuccess(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorConstant.white,
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/upload_success.svg'),
              const SizedBox(
                height: 5.0,
              ),
              Text("Yay! 📸",
                  style: TextStyleConstant.heading4.copyWith(
                      color: ColorConstant.neutral950,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 4.0,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  textAlign: TextAlign.center,
                  "Your photo has been successfully saved. Keep tracking your plant's growth! 🌱📈",
                  style: TextStyleConstant.heading4.copyWith(
                    color: ColorConstant.neutral950,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
