
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/verify_controller.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/views/verify/widget/confirm_description_verify_widget.dart';
import 'package:plantopia/views/verify/widget/custom_appbar_verify_widget.dart';

class VerifyView extends StatelessWidget {
  final VerifyController controller = Get.put(VerifyController());
  VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;
  LoginParamsModel? loginParams;
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
                    focusedBorderColor: ColorConstant.neutral950,
                    cursorColor: ColorConstant.neutral950,
                    keyboardType: TextInputType.number,
                    disabledBorderColor: ColorConstant.danger500,
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
                        if (kDebugMode) {
                          print(result?.toJson());
                        }
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
                              : ColorConstant.neutral500,
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
