// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/forgot_password_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/verify/widget/confirm_description_verify_widget.dart';
import 'package:plantopia/views/verify/widget/custom_appbar_verify_widget.dart';

class VerifyForgotPasswordView extends StatelessWidget {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  VerifyForgotPasswordView({super.key});

  Color? colorCurrent;



  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final String email = arguments['email'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              const CustomAppbarVerifyWidget(),
              const SizedBox(
                height: 32.0,
              ),
              const ConfirmDescriptionWidget(),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Obx(
                  () => OtpTextField(
                    autoFocus: true,
                    numberOfFields: 6,
                    filled: true,
                    showFieldAsBox: true,
                    fieldWidth: 53,
                    borderWidth: 0.5,
                    enabledBorderColor: controller.borderVerifyColor.value,
                    focusedBorderColor: Colors.black,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    disabledBorderColor: Colors.red,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textStyle: TextStyle(color: colorCurrent ?? Colors.black),
                    borderRadius: BorderRadius.circular(12),
                    onSubmit: (String otpUser) async {
                     await controller.verification(
                          email: email, otp: otpUser);
         
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Didn’t receive the code? ",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  Obx(
                    () => TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: controller.start.value == 0
                          ? () async {
                              await controller.resendOTP(context, email: email);
                            }
                          : null,
                      child: Text(
                        controller.start.value == 0
                            ? "Resend it"
                            : "Resend in ${controller.start.value}",
                        style: TextStyle(
                          color: controller.start.value == 0
                              ? const Color(0xFF10B981)
                              : Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
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
              SvgPicture.asset('assets/onboarding/success.svg'),
              const Text(
                "Yay!",
                style: TextStyle(
                  color: Color(0xFF545F71),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              const SizedBox(
                width: 250,
                child: Text(
                  textAlign: TextAlign.center,
                  'You’ve successfully signed up. Excited to grow with you! 🌿',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
