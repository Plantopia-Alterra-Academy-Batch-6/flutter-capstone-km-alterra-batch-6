
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/login_form_controller.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_button_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_text_form_field_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_login_google_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_text_button_forgot_password_widget.dart';

class LoginSectionWidget extends StatefulWidget {
  const LoginSectionWidget({super.key});

  @override
  State<LoginSectionWidget> createState() => _LoginSectionWidgetState();
}

class _LoginSectionWidgetState extends State<LoginSectionWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());
  final LoginFormController loginFormController =
      Get.put(LoginFormController());

  @override
  void initState() {
    emailController.text = loginFormController.emailInit.value;
    passwordController.text = loginFormController.passwordInit.value;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Obx(
                () => CustomAuthTextFormFieldWidget(
                  hintText: 'Email',
                  isEmailFailed: loginFormController.isFailedEmail.value,
                  isEnable: loginFormController.isEnableButtonEmail.value,
                  keyboardType: TextInputType.emailAddress,
                  errorText: loginFormController.errorEmail.value,
                  controller: emailController,
                  onChanged: (value) async {
                    loginFormController.setEmail(value);
                  },
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Obx(
                () => CustomAuthTextFormFieldWidget(
                  hintText: 'Password',
                  isEnable: loginFormController.isEnableButtonPassword.value,
                  showPassword: loginFormController.showPassword.value,
                  controller: passwordController,
                  errorText: loginFormController.errorPassword.value,
                  onChanged: (value) async {
                    loginFormController.setPassword(value);
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        loginFormController.showPassword.value =
                            !loginFormController.showPassword.value;
                      },
                      icon: Icon(
                        loginFormController.showPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: loginFormController.showPassword.value
                            ? ColorConstant.primary900
                            : ColorConstant.neutral900,
                        size: 20,
                      )),
                ),
              ),
              const CustomTextButtonForgotPasswordWidget(),
              const SizedBox(
                height: 24.0,
              ),
              Obx(
                () => CustomAuthButtonWidget(
                  isActive: loginFormController.isEnableButtonEmail.value &&
                      loginFormController.isEnableButtonPassword.value,
                  text: 'Login',
                  onPressed: () async {
                    LoginParamsModel loginParams = LoginParamsModel(
                        email: emailController.text,
                        password: passwordController.text);
                    await authController.login(
                        loginParams: loginParams, isOnLogin: true);
                  },
                ),
              ),
              const CustomLoginGoogleWidget()
            ],
          ),
        )
      ],
    );
  }
}
