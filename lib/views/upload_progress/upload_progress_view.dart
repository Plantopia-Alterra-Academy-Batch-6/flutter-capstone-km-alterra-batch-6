import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/upload_progress_controller.dart';
import 'package:plantopia/views/upload_progress/widget/all_photos_widget.dart';
import 'package:plantopia/views/upload_progress/widget/custom_snackbar_progress_widget.dart';
import 'package:plantopia/views/upload_progress/widget/custom_upload_progress_button_widget.dart';
import 'package:plantopia/views/upload_progress/widget/dotted_border_image_widget.dart';
import 'package:plantopia/views/upload_progress/widget/error_size_photo.dart';

class UploadProgressView extends StatefulWidget {
  UploadProgressView({super.key}) {
    Get.lazyPut<UploadProgressController>(() => UploadProgressController());
  }

  @override
  _UploadProgressViewState createState() => _UploadProgressViewState();
}

class _UploadProgressViewState extends State<UploadProgressView> {
  XFile? pickedFile;
  File? _image;
  bool isImageLarge = false;
  bool isActiveButton = false;
  final UploadProgressController uploadProgressController =
      Get.put(UploadProgressController());

  Future<void> _pickImage() async {
    var maxFileSizeInBytes = 2 * 1048576;
    final ImagePicker picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    var imagePath = await pickedFile!.readAsBytes();

    var fileSize = imagePath.length;
    if (fileSize <= maxFileSizeInBytes) {
      setState(() {
        isImageLarge = false;
        _image = File(pickedFile!.path);
        isActiveButton = true;
      });
    } else {
      setState(() {
        _image = null;
        isImageLarge = true;
        isActiveButton = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    uploadProgressController.getPlantProgress(1);
  }

  @override
  Widget build(BuildContext context) {
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
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? const DottedBorderImageWidget()
                      : Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6)),
                          height: 300,
                          width: double.infinity,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                isImageLarge ? const ErrorSizePhotoWidget() : Container(),
                const SizedBox(
                  height: 20.0,
                ),
                CustomUploadProgressButtonWidget(
                  isActive: isActiveButton,
                  onPressed: () async {
                    if (_image != null) {
                      bool result = await uploadProgressController
                          .uploadProgress("1", pickedFile!);
                      if (result) {
                        alertsuccess(context);
                        setState(() {
                          _image = null;
                          isActiveButton = false;
                        });
                      }
                    } else {
                      CustomSnackbarProgressWidget.show(context, onPressed: () {
                        _pickImage();
                      });
                    }
                  },
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
