import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/upload_progress/widget/custom_upload_progress_button_widget.dart';

class UploadProgressView extends StatefulWidget {
  const UploadProgressView({super.key});

  @override
  _UploadProgressViewState createState() => _UploadProgressViewState();
}

class _UploadProgressViewState extends State<UploadProgressView> {
  File? _image;
  bool isImageLarge = false;
  bool isActiveButton = false;

  Future<void> _pickImage() async {
    var maxFileSizeInBytes = 2 * 1048576;
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    var imagePath = await pickedFile!.readAsBytes();

    var fileSize = imagePath.length; // Get the file size in bytes
    if (fileSize <= maxFileSizeInBytes) {
      setState(() {
        isImageLarge = false;
        _image = File(pickedFile.path);
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
                      ? DottedBorder(
                          color: ColorConstant.neutral300,
                          radius: const Radius.circular(6),
                          borderType: BorderType.RRect,
                          strokeWidth: 1.2,
                          dashPattern: const [11],
                          child: SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/upload_photo.svg"),
                                    const SizedBox(
                                      height: 9.76,
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        text: 'Upload Your First Plant Image',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "(max. 2 MB)",
                                      style: TextStyleConstant.caption.copyWith(
                                          color: ColorConstant.neutral500,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              )),
                        )
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
                isImageLarge
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/error-image.svg"),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Your photo is too large! It must be under 2 MB. ",
                            style: TextStyleConstant.paragraph.copyWith(
                              fontSize: 14.0,
                              color: ColorConstant.danger500,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 20.0,
                ),
                CustomUploadProgressButtonWidget(
                  isActive: isActiveButton,
                  onPressed: () => alertsuccess(context),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "All Photos",
                  style: TextStyleConstant.title
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "You haven't added any photos yet. ",
                        style: TextStyleConstant.paragraph.copyWith(
                          fontSize: 14.0,
                          color: ColorConstant.neutral400,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        " Upload your first plant photo and watch your ",
                        style: TextStyleConstant.paragraph.copyWith(
                          fontSize: 14.0,
                          color: ColorConstant.neutral400,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "garden grow! 🪴 ",
                        style: TextStyleConstant.paragraph.copyWith(
                          fontSize: 14.0,
                          color: ColorConstant.neutral400,
                        ),
                      ),
                    ],
                  ),
                ),
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
