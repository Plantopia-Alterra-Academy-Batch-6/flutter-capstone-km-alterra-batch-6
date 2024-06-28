
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
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
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.white,
        body: SafeArea(
          child: Obx(
            () => authController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                        color: ColorConstant.primary500),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        const CustomAuthAppbarWidget(),
                        Obx(
                          () => DefaultTabController(
                            length: 2,
                            initialIndex: authController.authSection.value,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Color(0xFFF3F4F6),
                                  ),
                                  constraints:
                                      const BoxConstraints.expand(height: 47),
                                  child: TabBar(
                                      onTap: (value) {
                                        authController.authSection.value =
                                            value;
                                      },
                                      splashBorderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(8)),
                                      dividerHeight: 0,
                                      labelColor: ColorConstant.white,
                                      indicatorPadding: const EdgeInsets.all(5),
                                      indicator: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color: Color(0xFF10B981),
                                      ),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorColor: ColorConstant.primary500,
                                      unselectedLabelStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      labelStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      tabs: const [
                                        Tab(
                                          child: Text("Log in"),
                                        ),
                                        Tab(
                                          child: Text("Sign Up"),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 600,
                                  child: TabBarView(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: LoginSectionWidget(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
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
          ),
        ));
  }
}
