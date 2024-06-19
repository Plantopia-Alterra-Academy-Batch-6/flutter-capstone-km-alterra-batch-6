// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/verify_controller.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/views/verify/widget/confirm_description_verify_widget.dart';
import 'package:plantopia/views/verify/widget/custom_appbar_verify_widget.dart';

// ignore: must_be_immutable
class VerifyView extends StatelessWidget {
  final VerifyController controller = Get.put(VerifyController());
  VerifyView({super.key});

  String? email;
  LoginParamsModel? loginParams;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final Map arguments = Get.arguments;
    if (arguments['loginParams'] != null) {
      loginParams = arguments['loginParams'];
    } else {
      email = arguments['email'];
    }

    return Scaffold(
      backgroundColor: ColorConstant.white,
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
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 20.0,
                ),
                child: Obx(
                  () => OtpTextField(
                    autoFocus: true,
                    numberOfFields: 4,
                    filled: true,
                    showFieldAsBox: true,
                    fieldWidth: 70,
                    borderWidth: 0.8,
                    borderColor: ColorConstant.danger500,
                    enabledBorderColor: controller.borderVerifyColor.value,
                    focusedBorderColor: Colors.black,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    disabledBorderColor: Colors.red,
                    contentPadding: const EdgeInsets.symmetric(vertical: 22),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textStyle: TextStyle(color: controller.numberColor.value),
                    borderRadius: BorderRadius.circular(12),
                    onSubmit: (String otpUser) async {
                      if (arguments['loginParams'] != null) {
                        final LoginParamsModel? result =
                            await controller.verificationRegister(
                                loginParams: loginParams!, otp: otpUser);

                        print(result?.toJson());

                        //melakukan login otomatis ketika akun telah verifikasi
                        if (result != null) {
                          await authController.login(
                              loginParams: result,
                              backToLogin:
                                  arguments['isNotVerifiedWhenLogin'] != null
                                      ? true
                                      : false);
                        }
                      } else {
                        await controller.verificationForgotPassword(
                            email: email!, otp: otpUser);
                      }
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
                              if (arguments['loginParams'] != null) {
                                await controller.resendOTP(
                                    email: loginParams!.email!);
                              } else {
                                await controller.resendOTP(email: email!);
                              }
                            }
                          : null,
                      child: Text(
                        controller.start.value == 0
                            ? "Resend it"
                            : "Resend in ${controller.start.value}",
                        style: TextStyle(
                          color: controller.start.value == 0
                              ? ColorConstant.primary500
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
}
