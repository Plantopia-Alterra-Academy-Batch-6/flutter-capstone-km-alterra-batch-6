import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantopia/controllers/login_form_controller.dart';
import 'package:plantopia/controllers/sign_up_form_controller.dart';
import 'package:plantopia/controllers/verify_controller.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/models/signup_params_model.dart';
import 'package:plantopia/models/user_model.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/allow_notif/allow_notif_view.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:plantopia/views/verify/widget/custom_dialog_success_widget.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  RxInt authSection = 0.obs;

  // Login
  Future<void> login(
      {required LoginParamsModel loginParams,
      bool isOnLogin = false,
      bool backToLogin = false}) async {
    isLoading.value = true;
    final loginFormController = Get.find<LoginFormController>();
    try {
      String? newToken = await refreshFcmToken();
      loginParams.fcmToken = newToken;
      final String result = await AuthService.login(loginParams: loginParams);
      await UserTokenPref.setToken(result);
      loginFormController.onClose();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(
          CustomDialogSuccess(
            isOnLogin: isOnLogin,
          ),
        );
      });
      getUser();
      checkAllowNotification();
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 400) {
          loginFormController.errorPassword.value =
              "Enter a valid email and password";
          loginFormController.isFailedEmail.value = true;
          authSection.value = 0;
          if (backToLogin) {
            Get.offAllNamed(AppRoutes.auth);
          }
        } else if (e.code == 401) {
          // disini saya melakukan pengecekan ketika mendapat error 401 maka langsung ke halaman verifikasi
          final VerifyController verifyController = Get.put(VerifyController());
          verifyController.resendOTP(email: loginParams.email!);
          loginFormController.errorPassword.value =
              "Enter a valid email and password";
          loginFormController.isFailedEmail.value = true;
          authSection.value = 0;
          Get.toNamed(AppRoutes.verify, arguments: {
            'loginParams': loginParams,
            'isNotVerifiedWhenLogin': true
          });
        } else {
          Get.snackbar('Error', '$e');
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAllowNotification() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      Get.offAll(const BottomNavigationBarGlobalWidget());
    } else {
      Get.to(const AllowNotificationView());
    }
  }

  // Sign Up
  Future<void> signUp(SignUpParamsModel signUpParamsModel) async {
    isLoading.value = true;
    try {
      // melakukan refresh fcm token saat sign up untuk mendapatkan token baru
      String? newToken = await refreshFcmToken();
      signUpParamsModel.fcmToken = newToken;
      UserModel? result = await AuthService.signUp(signUpParamsModel);
      currentUser.value = result;

      // mengirimkan login params ke verifikasi page supaya jika berhasil verify, akan otomatis login menggunakan login params ini
      LoginParamsModel loginParams = LoginParamsModel(
          email: signUpParamsModel.email!,
          password: signUpParamsModel.password!);

      Get.toNamed(AppRoutes.verify, arguments: {'loginParams': loginParams});
    } catch (e) {
      if (e is CustomException) {
        if (e.code == 409) {
          final signUpController = Get.find<SignUpFormController>();

          signUpController.errorEmail.value = e.message;
        }
      } else {
        Get.snackbar('Error', '$e');
      }
      authSection.value = 1;
    } finally {
      isLoading.value = false;
    }
  }

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
        }
      }
    } catch (e) {
      if (e is CustomException) {
        // Get.snackbar('error [${e.code}]', e.message);
      } else {
        Get.snackbar('error', '$e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // refresh fcm token
  Future<String?> refreshFcmToken() async {
    try {
      final newToken = await FirebaseMessaging.instance
          .deleteToken()
          .then((value) => FirebaseMessaging.instance.getToken());

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
