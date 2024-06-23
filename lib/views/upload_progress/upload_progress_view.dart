import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/upload_progress_controller.dart';
import 'package:plantopia/views/upload_progress/widget/all_photos_widget.dart';
import 'package:plantopia/views/upload_progress/widget/custom_snackbar_progress_widget.dart';
import 'package:plantopia/views/upload_progress/widget/custom_upload_progress_button_widget.dart';
import 'package:plantopia/views/upload_progress/widget/dotted_border_image_widget.dart';
import 'package:plantopia/views/upload_progress/widget/error_size_photo.dart';

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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                    onTap: controller.pickImage,
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
                          // ignore: use_build_context_synchronously
                          alertsuccess(context);

                          controller.image.value = null;
                          controller.isActiveButton.value = false;
                        }
                      } else {
                        CustomSnackbarProgressWidget.show(context,
                            onPressed: () {
                          controller.pickImage();
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

  void alertsuccess(context) {
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
