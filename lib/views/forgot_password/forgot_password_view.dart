import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/forgot_password_controller.dart';
import 'package:plantopia/controllers/verify_controller.dart';
import 'package:plantopia/views/forgot_password/widget/custom_appbar_forgot_password_widget.dart';
import 'package:plantopia/views/forgot_password/widget/custom_button_forgot_password_widget.dart';
import 'package:plantopia/views/forgot_password/widget/custom_formfield_forgot_password_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());
    final VerifyController verifyController = Get.put(VerifyController());

    TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppbarForgotPasswordWidget(
                title: "Forgot Password",
                subtitle:
                    "Enter your email and get instruction for resetting your password",
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Obx(
                      () => CustomFormfieldForgotPasswordWidget(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email',
                          errorText: forgotPasswordController.errorEmail.value,
                          onChanged: (e) async {
                            forgotPasswordController.setEmail(e);
                          }),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    Obx(
                      () => CustomButtonForgotPasswordWidget(
                          isLoading: verifyController.isLoading.value,
                          onPressed: () async {
                            await verifyController.resendOTP(
                                email: emailController.text);
                          },
                          isActive: forgotPasswordController
                              .isEnableButtonEmail.value,
                          text: "Get Instruction"),
                    ),
                    const SizedBox(
                      height: 28.0,
                    ),
                    DottedBorder(
                        color: ColorConstant.danger500,
                        radius: const Radius.circular(6),
                        borderType: BorderType.RRect,
                        strokeWidth: 1.2,
                        dashPattern: const [11],
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 86,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Password Tips",
                                  style: TextStyleConstant.subtitle.copyWith(
                                      color: ColorConstant.danger500,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                  "Create a memorable and secure password to reduce the need for resets.",
                                  style: TextStyleConstant.paragraph.copyWith(
                                      color: ColorConstant.danger500)),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
