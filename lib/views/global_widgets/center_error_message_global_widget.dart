import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CenterErrorMessageGlobalWidget extends StatelessWidget {
  final String? pageName;

  const CenterErrorMessageGlobalWidget({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double sizedBoxHeight = screenHeight / 3; // Adjust the divisor as needed

    return Column(
      children: [
        SizedBox(height: sizedBoxHeight),
        Center(
          child: Text(
            "Failed to load $pageName",
            style: TextStyleConstant.subtitle.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
