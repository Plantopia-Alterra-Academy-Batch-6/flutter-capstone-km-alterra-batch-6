import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormController extends GetxController {
  final isValidOtp = Rxn<bool>();

  void validatorOtp(String otp, String validOtp) {
    if (otp == validOtp) {
      isValidOtp.value = true;
    } else {
      isValidOtp.value = false;
    }
  }

 

  final enableColor = const Color(0xFF10B981);
  final errorName = Rxn<String>();
  RxBool isEnableButtonName = false.obs;
  final borderName = Rx<Color>(Colors.black);
  final errorEmail = Rxn<String>();
  final borderEmail = Rx<Color>(Colors.black);
  RxBool isEnableButtonEmail = false.obs;
  final errorPassword = Rxn<String>();
  final borderPassword = Rx<Color>(Colors.black);
  RxBool isEnableButtonPassword = false.obs;

  RxString nameInit = ''.obs;
  RxString emailInit = ''.obs;
  RxString passwordInit = ''.obs;

  void validatorName(String name) {
    nameInit.value = name;
    if (name.isEmpty) {
      errorName.value = "Name can't be empty";
      isEnableButtonName.value = false;
      borderName.value = Colors.red;
    } else {
      errorName.value = null;
      isEnableButtonName.value = true;
      borderName.value = enableColor;
    }
  }

  void validatorEmail(String email) {
    emailInit.value = email;
    if (email.isEmpty) {
      errorEmail.value = "Email can't be empty";
      isEnableButtonEmail.value = false;
      borderEmail.value = Colors.red;
    } else if (!email.isEmail) {
      errorEmail.value = 'Please provide a correct email address';
      isEnableButtonEmail.value = false;
      borderEmail.value = Colors.red;
    } else {
      borderEmail.value = enableColor;
      errorEmail.value = null;
      isEnableButtonEmail.value = true;
    }
  }

  void validatorPassword(String password) {
    passwordInit.value = password;
    if (password.isEmpty) {
      errorPassword.value = "Password can't be empty";
      isEnableButtonPassword.value = false;
      borderPassword.value = Colors.red;
    } else if (password.length < 8 || password.length > 16) {
      errorPassword.value = 'Password should contain 8-16 characters ';
      isEnableButtonPassword.value = false;
      borderPassword.value = Colors.red;
    } else {
      errorPassword.value = null;
      isEnableButtonPassword.value = true;
      borderPassword.value = enableColor;
    }
  }

  // @override
  // void onClose() {
  //   errorName.value = null;
  //   borderName.value = Colors.black;
  //   errorEmail.value = null;
  //   borderEmail.value = Colors.black;
  //   isEnableButtonEmail.value = false;
  //   errorPassword.value = null;
  //   borderPassword.value = Colors.black;
  //   isEnableButtonPassword.value = false;
  //   super.onClose();
  // }
}
