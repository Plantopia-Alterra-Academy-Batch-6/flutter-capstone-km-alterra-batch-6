import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/upload_progress_controller.dart';

class SnackbarOptionWidget extends StatelessWidget {
  const SnackbarOptionWidget({super.key, required this.controller});
  final UploadProgressController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstant.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 80),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: ButtonStyle(
                  overlayColor:
                      WidgetStateProperty.all(ColorConstant.neutral100)),
              onPressed: controller.pickImageFromCamera,
              label: Row(
                children: [
                  Icon(Icons.camera_alt, color: ColorConstant.primary500),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text("Camera",
                      style: TextStyleConstant.subtitle
                          .copyWith(color: ColorConstant.primary500))
                ],
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  overlayColor:
                      WidgetStateProperty.all(ColorConstant.neutral100)),
              onPressed: controller.pickImageFromGallery,
              label: Row(
                children: [
                  Icon(Icons.photo, color: ColorConstant.primary500),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text("Gallery",
                      style: TextStyleConstant.subtitle
                          .copyWith(color: ColorConstant.primary500))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
