import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CenterCircularProgressGlobalWidget extends StatelessWidget {
  const CenterCircularProgressGlobalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double sizedBoxHeight = screenHeight / 3; // Adjust the divisor as needed

    return Column(
      children: [
        SizedBox(height: sizedBoxHeight),
        Center(
          child: CircularProgressIndicator(color: ColorConstant.primary500)
        ),
      ],
    );
  }
}
