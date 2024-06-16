import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';

class ForgotPasswordController extends GetxController {
  RxBool isEnableButtonEmail = false.obs;
  final errorEmail = Rxn<String>();
  final borderEmail = Rx<Color>(ColorConstant.neutral300);
  final textEmailColor = Rx<Color>(ColorConstant.neutral950);

  RxString emailInit = ''.obs;

  ForgotPasswordController() {
    debounce(emailInit, (value) {
      validatorEmail(value);
    }, time: const Duration(milliseconds: 700));
  }

  void setEmail(String value) {
    emailInit.value = value;
  }

  void validatorEmail(String value) {
    if (value.isEmpty) {
      errorEmail.value = "Email can't be empty";
      isEnableButtonEmail.value = false;
      borderEmail.value = ColorConstant.danger500;
      textEmailColor.value = ColorConstant.danger500;
    } else if (!value.isEmail) {
      errorEmail.value = 'Please provide a correct email address';
      isEnableButtonEmail.value = false;
      borderEmail.value = ColorConstant.danger500;
      textEmailColor.value = ColorConstant.danger500;
    } else {
      errorEmail.value = null;
      isEnableButtonEmail.value = true;
      borderEmail.value = ColorConstant.neutral950;
      textEmailColor.value = ColorConstant.neutral950;
    }
  }
}
