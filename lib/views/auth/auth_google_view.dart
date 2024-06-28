
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/auth_google_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthGoogleView extends StatelessWidget {
  const AuthGoogleView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthGoogleController controller = Get.put(AuthGoogleController());

    controller.initWebView();

    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (controller.isLoading.value) {
              return CircularProgressIndicator(
                color: ColorConstant.primary500,
              );
            } else {
              return WebViewWidget(controller: controller.webViewController);
            }
          }),
        ),
      ),
    );
  }
}
