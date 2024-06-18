import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/service/forgot_password_service.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/custom_snackbar_bottom_widget.dart';

class ForgotPasswordController extends GetxController {
  final borderVerifyColor = Rx<Color>(Colors.black);
  RxBool isLoading = false.obs;
  RxInt start = 0.obs;
  Timer? _timer;

  void startTimer() {
    start.value = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    errorEmail.value = null;
    isEnableButtonEmail.value = false;
    errorPassword.value = null;
    isEnableButtonPassword.value = false;
    super.onClose();
  }

  Future<void> verification(
      {required String email, required String otp}) async {
    isLoading.value = true;
    try {
      final CustomException result =
          await ForgotPasswordService.verification(email: email, otp: otp);
      if (result.code == 200) {
        borderVerifyColor.value = const Color(0xFF10B981);
        Get.toNamed(AppRoutes.setNewPassword, arguments: {'email': result});
      }
    } catch (e) {
      if (e is CustomException) {
        borderVerifyColor.value = Colors.red;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOTP(context, {required String email}) async {
    startTimer();
    try {
      final CustomException? result =
          await ForgotPasswordService.resendOTP(email: email);
      if (result != null) {
        Get.toNamed(AppRoutes.verifyForgotPassword,
            arguments: {'email': email});
      }
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 400) {
          CustomSnackbarBottomWidget.show(context,
              title: "failed to resend OTP ${e.message}");
        } else {
          CustomSnackbarBottomWidget.show(context,
              title: "failed to resend OTP ${e.message}");
        }
      }
    }
  }

  Future<bool> postForgotPassword(
      {required String email, required String password}) async {
    isLoading.value = true;
    try {
      final result = await ForgotPasswordService.postForgotPassword(
          email: email, password: password);

      if (result.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool showPassword = false.obs;
  final enableColor = ColorConstant.primary500;
  final errorEmail = Rxn<String>();
  RxBool isEnableButtonEmail = false.obs;
  final errorPassword = Rxn<String>();
  RxBool isEnableButtonPassword = false.obs;
  RxString emailInit = ''.obs;
  RxString passwordInit = ''.obs;

  ForgotPasswordController() {
    debounce(emailInit, (value) {
      validatorEmail(value);
    }, time: const Duration(milliseconds: 800));
    debounce(passwordInit, (value) {
      validatorPassword(value);
    }, time: const Duration(milliseconds: 800));
  }

  void setEmail(value) {
    emailInit.value = value;
  }

  void setPassword(value) {
    passwordInit.value = value;
  }

  void validatorEmail(String value) {
    if (value.isEmpty) {
      errorEmail.value = "Email can't be empty";
      isEnableButtonEmail.value = false;
    } else if (!value.isEmail) {
      errorEmail.value = 'Please provide a correct email address';
      isEnableButtonEmail.value = false;
    } else {
      errorEmail.value = null;
      isEnableButtonEmail.value = true;
    }
  }

  void validatorPassword(String value) {
    if (value.isEmpty) {
      errorPassword.value = "Password can't be empty";
      isEnableButtonPassword.value = false;
    } else if (value.length < 8 || value.length > 16) {
      errorPassword.value = 'Password should contain 8-16 characters ';
      isEnableButtonPassword.value = false;
    } else {
      errorPassword.value = null;
      isEnableButtonPassword.value = true;
    }
  }
}
