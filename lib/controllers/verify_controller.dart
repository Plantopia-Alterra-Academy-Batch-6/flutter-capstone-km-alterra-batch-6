import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/service/verify_service.dart';
import 'package:plantopia/utils/app_routes.dart';

class VerifyController extends GetxController {
  final borderVerifyColor = Rx<Color>(Colors.grey);
  final numberColor = Rx<Color>(Colors.black);
  RxBool isLoading = false.obs;
  RxInt start = 0.obs;
  Timer? _timer;

  @override
  void onClose() {
    _timer?.cancel();
    borderVerifyColor.value = Colors.grey;
    numberColor.value = Colors.black;

    super.onClose();
  }

  void startTimer() {
    start.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  Future<LoginParamsModel?> verificationRegister(
      {required LoginParamsModel loginParams, required String otp}) async {
    isLoading.value = true;
    try {
      final CustomException result =
          await VerifyService.verification(email: loginParams.email!, otp: otp);
      if (result.code == 200) {
        borderVerifyColor.value = ColorConstant.primary500;
        numberColor.value = ColorConstant.primary500;

        return loginParams;
      }
    } catch (e) {
      if (e is CustomException) {
        borderVerifyColor.value = ColorConstant.danger500;
        numberColor.value = ColorConstant.danger500;
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<void> verificationForgotPassword(
      {required String email, required String otp}) async {
    isLoading.value = true;
    try {
      final CustomException result =
          await VerifyService.verification(email: email, otp: otp);
      if (result.code == 200) {
        borderVerifyColor.value = ColorConstant.primary500;
        numberColor.value = ColorConstant.primary500;
        Get.toNamed(AppRoutes.setNewPassword, arguments: {'email': email});
      }
    } catch (e) {
      if (e is CustomException) {
        borderVerifyColor.value = ColorConstant.danger500;
        numberColor.value = ColorConstant.danger500;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOTP({required String email}) async {
    isLoading.value = true;
    startTimer();
    try {
      final CustomException? result =
          await VerifyService.resendOTP(email: email);
      if (result?.code == 200) {
        Get.toNamed(AppRoutes.verify, arguments: {'email': email});
      }
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 400) {
          if (kDebugMode) {
            print(e.message);
          }
        } else {
          if (kDebugMode) {
            print(e.message);
          }
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
