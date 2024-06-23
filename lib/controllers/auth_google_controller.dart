import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/views/allow_notif/allow_notif_view.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthGoogleController extends GetxController {
  late WebViewController webViewController;
  RxBool isLoading = false.obs;
  final AuthController authController = Get.put(AuthController());
  @override
  void onInit() {
    super.onInit();
    initWebView();
  }

  Future<void> initWebView() async {
    isLoading.value = true;
    webViewController = WebViewController()
      ..setBackgroundColor(Colors.white)
      ..setUserAgent("random")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onUrlChange: (change) async {
          print("this is change : ${change.url}");
          if (change.url != null) {
            await getProfilBytoken(change.url!);
          }
        }, onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://your-redirect-url.com')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        }),
      );
    clearCacheAndLoadLogin();
  }

  Future<void> clearCacheAndLoadLogin() async {
    await webViewController.clearCache();
    await webViewController.clearLocalStorage();
    await WebViewCookieManager().clearCookies();
    webViewController.loadRequest(Uri.parse(
        'https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/login-google'));
    isLoading.value = false;
  }

  Future<void> getProfilBytoken(String url) async {
    try {
      final response = await Dio().get(url);

      if (response.data['data'] != null) {       
         // String token =
        //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Inp1d2l5MTBAZ21haWwuY29tIiwiaWQiOjM0LCJyb2xlIjoidXNlciJ9.NNgEj8vlxOQpGA4ecHn_KPvorxcVi7Xoucrodhl-8-4";

        String token = response.data['data'];

        await UserTokenPref.setToken(token);

        await authController.getUser();
        checkAllowNotification();
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
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
}


