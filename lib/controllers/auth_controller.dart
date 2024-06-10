import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/login_form_controller.dart';
import 'package:plantopia/controllers/sign_up_form_controller.dart';
import 'package:plantopia/helpers/fcm_token.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/models/signup_params_model.dart';
import 'package:plantopia/models/user_model.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/views/auth/allow_notif_view.dart';
import 'package:plantopia/views/auth/verify_view.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  RxString currentFcmToken = "".obs;

  RxInt authSection = 0.obs;
  final borderVerifyColor = Rx<Color>(Colors.black);

  // Mendapatkan user
  Future<void> getUser() async {
    isLoading.value = true;
    try {
      final String? token = await UserTokenPref.getToken();
      if (token != null) {
        final UserModel? result = await AuthService.getUser(token);
        await UserTokenPref.setUserId(result?.id ?? -1);
        if (result != null) {
          currentUser.value = result;
          print("cek currentUser name :  ${currentUser.value?.name}");
        }
      }
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar('error [${e.code}]', e.message);
      } else {
        Get.snackbar('error', '$e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Login
  Future<void> login({required LoginParamsModel loginParams}) async {
    isLoading.value = true;
    final loginFormController = Get.find<LoginFormController>();
    try {
      final String result = await AuthService.login(loginParams: loginParams);
      await UserTokenPref.setToken(result);
      loginFormController.onClose();
      Get.to(const AllowNotificationView());
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 400) {
          loginFormController.errorPassword.value =
              "masukkan email & password yang benar";
          loginFormController.borderEmail.value = Colors.red;
          loginFormController.borderPassword.value = Colors.red;
          authSection.value = 0;
          Get.snackbar('Invalid', e.message);
        } else {
          Get.snackbar('Error', '$e');
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Sign Up
  Future<void> signUp(SignUpParamsModel signUpParamsModel) async {
    isLoading.value = true;
    try {
      // melakukan refresh fcm token saat sign up untuk mendapatkan token baru
      String? newToken = await refreshFcmToken();
      signUpParamsModel.fcmToken = newToken;
      print(newToken);

      UserModel? result = await AuthService.signUp(signUpParamsModel);
      currentUser.value = result;

      // mengirimkan login params ke verifikasi page supaya jika berhasil verify
      // akan otomatis login menggunakan login params ini
      LoginParamsModel loginParams = LoginParamsModel(
          email: signUpParamsModel.email!,
          password: signUpParamsModel.password!);
      Get.to(VerificationView(
        loginParamsModel: loginParams,
        // otpServer: currentUser.value!.otp,
      ));
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 409) {
          final signUpController = Get.find<SignUpFormController>();

          signUpController.errorEmail.value = e.message;
          signUpController.borderEmail.value = Colors.red;
          Get.snackbar('Failed', e.message);
        }
      } else {
        Get.snackbar('Error', '$e');
      }
      authSection.value = 1;
    } finally {
      isLoading.value = false;
    }
  }

  // Verifikasi
  Future<LoginParamsModel?> verification(
      {required LoginParamsModel loginParams, required String otp}) async {
    isLoading.value = true;
    try {
      final CustomException result =
          await AuthService.verification(email: loginParams.email, otp: otp);
      if (result.code == 200) {
        borderVerifyColor.value = const Color(0xFF10B981);

        // menyimpan fcm token ke dalam shared preference
        await FcmTokenPref.setToken(currentFcmToken.value);

        return loginParams;
      }
    } catch (e) {
      if (e is CustomException) {
        borderVerifyColor.value = Colors.red;
        Get.snackbar('failed to Verification [${e.code}]', e.message);
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<void> resendOTP({required String email}) async {
    try {
      final CustomException? result = await AuthService.resendOTP(email: email);
      if (result != null) {
        Get.snackbar(result.message, result.code.toString());
      }
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 400) {
          Get.snackbar('failed to resend OTP', e.message);
        } else {
          Get.snackbar('failed to resend OTP', '$e');
        }
      }
    }
  }

  // refresh fcm token
  Future<String?> refreshFcmToken() async {
    try {
      final newToken = await FirebaseMessaging.instance
          .deleteToken()
          .then((value) => FirebaseMessaging.instance.getToken());

      // menyimpan newtoken ke dalam controller,currentFcmToken ini akan saya gunakan saat berhasil verifikasi
      newToken != null ? currentFcmToken.value = newToken : null;

      return newToken;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
    return null;
  }

//   final GoogleSignInService _googleSignInService = GoogleSignInService();
//   final Rx<User?> _user = Rx<User?>(null);
//   User? get user => _user.value;

//   @override
//   void onInit() {
//     super.onInit();
//     _user.bindStream(FirebaseAuth.instance.authStateChanges());
//   }

// //sign in with Google
//   Future<void> signInWithGoogle() async {
//     isLoading.value = true;
//     try {
//       User? user = await _googleSignInService.signInWithGoogle();
//       if (user != null) {
//         _user.value = user;
//         Get.snackbar('Success', 'Logged in as ${user.displayName}');
//         Get.offAll(() => const AllowNotificationView());
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to sign in with Google');
//     } finally {
//       isLoading.value = false;
//     }
//   }

// //sign out with Google
//   Future<void> signOutGoogle() async {
//     await _googleSignInService.signOut();
//     _user.value = null;
//     Get.snackbar('Success', 'Signed out');
//     Get.offAll(() => const AuthView());
//   }
}