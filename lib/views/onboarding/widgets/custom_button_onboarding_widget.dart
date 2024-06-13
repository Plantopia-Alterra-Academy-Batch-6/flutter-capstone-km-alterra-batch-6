import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomButtonOnBoardingWidget extends StatelessWidget {
  const CustomButtonOnBoardingWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color,
      required this.backgroundColor});

  final void Function()? onPressed;
  final String text;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0,
            backgroundColor: backgroundColor,
          ),
          onPressed: onPressed,
          child: Text(text,
              style: TextStyleConstant.subtitle
                  .copyWith(color: color, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
