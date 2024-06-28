import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/utils/base_url_util.dart';
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
      ..setBackgroundColor(ColorConstant.white)
      ..setUserAgent("random")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onUrlChange: (change) async {
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
        '${BaseUrlUtil.baseUrl}/login-google'));
    isLoading.value = false;
  }

  Future<void> getProfilBytoken(String url) async {
    try {
      final response = await Dio().get(url);

      if (response.data['data'] != null) {       

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


