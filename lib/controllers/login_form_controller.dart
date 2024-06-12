import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final enableColor = const Color(0xFF10B981);
  final errorEmail = Rxn<String>();
  final borderEmail = Rx<Color>(Colors.black);
  RxBool isEnableButtonEmail = false.obs;
  final errorPassword = Rxn<String>();
  final borderPassword = Rx<Color>(Colors.black);
  RxBool isEnableButtonPassword = false.obs;
  RxString emailInit = ''.obs;
  RxString passwordInit = ''.obs;

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

  @override
  void onClose() {
    errorEmail.value = null;
    borderEmail.value = Colors.black;
    isEnableButtonEmail.value = false;
    errorPassword.value = null;
    borderPassword.value = Colors.black;
    isEnableButtonPassword.value = false;
    super.onClose();
  }
}
