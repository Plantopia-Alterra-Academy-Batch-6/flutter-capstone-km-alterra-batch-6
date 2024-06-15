import 'package:flutter/material.dart';
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
}
