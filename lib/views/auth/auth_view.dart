// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/login_form_controller.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_appbar_widget.dart';
import 'package:plantopia/views/auth/widgets/login_section_widget.dart';
import 'package:plantopia/views/auth/widgets/signup_section_widget.dart';

class AuthView extends StatefulWidget {
  const AuthView({
    super.key,
  });

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final LoginFormController loginFormController =
      Get.put(LoginFormController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => authController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  const CustomAuthAppbarWidget(),
                  Obx(
                    () => DefaultTabController(
                      length: 2,
                      initialIndex: authController.authSection.value,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color(0xFFF3F4F6),
                            ),
                            constraints:
                                const BoxConstraints.expand(height: 45),
                            child: const TabBar(
                                splashBorderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                dividerHeight: 0,
                                labelColor: Colors.white,
                                indicatorPadding: EdgeInsets.all(5),
                                indicator: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xFF10B981),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: Colors.amber,
                                unselectedLabelStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                labelStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                tabs: [
                                  Tab(
                                    child: Text("Login"),
                                  ),
                                  Tab(
                                    child: Text("Sign Up"),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            // color: Colors.orange[200],
                            height: 600,
                            child: TabBarView(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: LoginSectionWidget(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: SignUpSectionWidget(),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}
