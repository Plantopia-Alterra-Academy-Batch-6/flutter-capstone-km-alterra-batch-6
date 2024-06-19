import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomSnackbarBottomWidget {
  static void show(BuildContext context, {required title, Color? color}) {
    final snackBar = SnackBar(
        backgroundColor: color ?? ColorConstant.neutral800,
        content: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyleConstant.paragraph
                    .copyWith(color: ColorConstant.white),
              ),
            ],
          ),
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
