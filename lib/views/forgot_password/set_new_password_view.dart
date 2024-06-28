import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/forgot_password_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/forgot_password/widget/custom_appbar_forgot_password_widget.dart';
import 'package:plantopia/views/forgot_password/widget/custom_button_forgot_password_widget.dart';
import 'package:plantopia/views/forgot_password/widget/custom_formfield_forgot_password_widget.dart';
import 'package:plantopia/views/global_widgets/custom_snackbar_bottom_widget.dart';

class SetNewPasswordView extends StatelessWidget {
  const SetNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller =
        Get.put(ForgotPasswordController());

    TextEditingController passwordController = TextEditingController();
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final String email = arguments?['email'] ?? '';

    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppbarForgotPasswordWidget(
                title: "Set a new password",
                subtitle:
                    "Create a new password. For your safety, avoid using old passwords",
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Obx(
                      () => CustomFormfieldForgotPasswordWidget(
                          showPassword: controller.showPassword.value,
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              },
                              icon: Icon(
                                controller.showPassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: controller.showPassword.value
                                    ? ColorConstant.neutral950
                                    : ColorConstant.neutral900,
                                size: 20,
                              )),
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          hintText: 'Password',
                          errorText: controller.errorPassword.value,
                          onChanged: (e) async {
                            controller.setPassword(e);
                          }),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    Obx(
                      () => CustomButtonForgotPasswordWidget(
                          isLoading: controller.isLoading.value,
                          onPressed: () async {
                            final bool result =
                                await controller.postForgotPassword(
                                    email: email,
                                    password: passwordController.text);
                            if (result) {
                              if (!context.mounted) return;
                              CustomSnackbarBottomWidget.show(context,
                                  title: "Password Updated Successfully");
                              Get.offNamed(AppRoutes.auth);
                            } else {
                              if (!context.mounted) return;
                              CustomSnackbarBottomWidget.show(context,
                                  title: "Failed to change new password");
                            }
                          },
                          isActive: controller.isEnableButtonPassword.value,
                          text: "Update Password"),
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    Center(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyleConstant.subtitle
                                .copyWith(color: ColorConstant.primary500),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
