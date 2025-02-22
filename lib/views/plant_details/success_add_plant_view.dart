import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';

class SuccessAddPlantView extends StatelessWidget {
  const SuccessAddPlantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/success_add_plant.png'),
            const SizedBox(height: 40),
            Text(
              "Congratulations!",
              style: TextStyleConstant.heading4
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: Text(
                "You've successfully added a new plant to your collection",
                style: TextStyleConstant.paragraph,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 74),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(
                      () => const BottomNavigationBarGlobalWidget(index: 2));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ColorConstant.primary500, 
                  fixedSize: const Size(400, 60), 
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child:  Text(
                  'View added plants',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.white, 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
