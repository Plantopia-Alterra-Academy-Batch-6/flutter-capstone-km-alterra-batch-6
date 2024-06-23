import 'dart:async';

import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/service/forgot_password_service.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  @override
  void onClose() {
    errorEmail.value = null;
    isEnableButtonEmail.value = false;
    errorPassword.value = null;
    isEnableButtonPassword.value = false;
    super.onClose();
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
