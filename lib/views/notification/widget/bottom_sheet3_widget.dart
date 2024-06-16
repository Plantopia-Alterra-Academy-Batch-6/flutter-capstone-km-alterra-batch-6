import 'package:flutter/material.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class BottomSheet3Widget extends StatelessWidget {
  const BottomSheet3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      height: 323,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(ImageConstant.successWatering),
            const SizedBox(
              height: 16,
            ),
            Text("Hurray! 💦",
                style: TextStyleConstant.heading4.copyWith(
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Your plant has been watered!\nKeep up the good care! 🙌",
              style: TextStyleConstant.paragraph,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
