// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_button_widget.dart';
import 'package:plantopia/views/home/home_view.dart';

class AllowNotificationView extends StatefulWidget {
  const AllowNotificationView({super.key});

  @override
  State<AllowNotificationView> createState() => _AllowNotificationViewState();
}

class _AllowNotificationViewState extends State<AllowNotificationView> {
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    await authController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/onboarding/allow-notif.svg'),
                  const SizedBox(
                    height: 32.0,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Allow Us to Remind You on Notification?",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    width: 230,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Don’t worry, we won’t spam you, you can turn this off anytime 😉',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            CustomAuthButtonWidget(
              isActive: true,
              text: "Allow Access",
              onPressed: () async {
                // String? userId = await UserTokenPref.getToken();
                // print(userId);

                Get.offAll(const HomeView());
              },
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                isSemanticButton: false,
                onPressed: () {},
                child: const Text(
                  "Maybe Next Time",
                  style: TextStyle(color: Color(0xFF10B981)),
                )),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
