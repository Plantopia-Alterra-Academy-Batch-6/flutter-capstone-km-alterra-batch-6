import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/upload_progress_controller.dart';
import 'package:plantopia/views/upload_progress/widget/all_photos_widget.dart';
import 'package:plantopia/views/upload_progress/widget/custom_snackbar_progress_widget.dart';
import 'package:plantopia/views/upload_progress/widget/custom_upload_progress_button_widget.dart';
import 'package:plantopia/views/upload_progress/widget/dotted_border_image_widget.dart';
import 'package:plantopia/views/upload_progress/widget/error_size_photo.dart';
import 'package:plantopia/views/upload_progress/widget/snackbar_option_widget.dart';

class UploadProgressView extends StatelessWidget {
  UploadProgressView({super.key}) {
    Get.lazyPut<UploadProgressController>(() => UploadProgressController());
  }
  @override
  Widget build(BuildContext context) {
    final UploadProgressController controller =
        Get.put(UploadProgressController());
    final plantId = Get.arguments["id"];
    return Scaffold(
      backgroundColor: ColorConstant.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Progress Photo",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.dialog(SnackbarOptionWidget(
                        controller: controller,
                      ));
                    },
                    child: controller.image.value == null
                        ? const DottedBorderImageWidget()
                        : Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)),
                            height: 300,
                            width: double.infinity,
                            child: Image.file(
                              controller.image.value!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Obx(
                  () => controller.isImageLarge.value
                      ? const ErrorSizePhotoWidget()
                      : Container(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(
                  () => CustomUploadProgressButtonWidget(
                    isLoading: controller.isButtonLoading.value,
                    isActive: controller.isActiveButton.value,
                    onPressed: () async {
                      if (controller.image.value != null) {
                        bool result = await controller.uploadProgress(plantId);
                        if (result) {
                          if (!context.mounted) return;
                          CustomSnackbarProgressWidget.alertsuccess(context);

                          controller.image.value = null;
                          controller.isActiveButton.value = false;
                        }
                      } else {
                        CustomSnackbarProgressWidget.show(context,
                            onPressed: () {
                          Get.dialog(SnackbarOptionWidget(
                            controller: controller,
                          ));
                        });
                      }
                    },
                  ),
                ),
                const AllPhotosWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
