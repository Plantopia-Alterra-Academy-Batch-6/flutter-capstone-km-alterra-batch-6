import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';

class SignUpFormController extends GetxController {
  final isValidOtp = Rxn<bool>();

  void validatorOtp(String otp, String validOtp) {
    if (otp == validOtp) {
      isValidOtp.value = true;
    } else {
      isValidOtp.value = false;
    }
  }

  SignUpFormController() {
    debounce(nameInit, (value) {
      validatorName(value);
    }, time: const Duration(milliseconds: 800));
    debounce(emailInit, (value) {
      validatorEmail(value);
    }, time: const Duration(milliseconds: 800));
    debounce(passwordInit, (value) {
      validatorPassword(value);
    }, time: const Duration(milliseconds: 800));
  }

  final enableColor = ColorConstant.primary500;
  final errorName = Rxn<String>();
  RxBool isEnableButtonName = false.obs;

  final errorEmail = Rxn<String>();
  RxBool isEnableButtonEmail = false.obs;

  final errorPassword = Rxn<String>();
  RxBool isEnableButtonPassword = false.obs;

  RxString nameInit = ''.obs;
  RxString emailInit = ''.obs;
  RxString passwordInit = ''.obs;

  void setName(value) {
    nameInit.value = value;
  }

  void setEmail(value) {
    emailInit.value = value;
  }

  void setPassword(value) {
    passwordInit.value = value;
  }

  void validatorName(String name) {
    if (name.isEmpty) {
      errorName.value = "Name can't be empty";
      isEnableButtonName.value = false;
    } else {
      errorName.value = null;
      isEnableButtonName.value = true;
    }
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
