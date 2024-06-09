// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/login_form_controller.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_button_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_text_form_field_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_login_google_widget.dart';

class LoginSectionWidget extends StatefulWidget {
  const LoginSectionWidget({super.key});

  @override
  State<LoginSectionWidget> createState() => _LoginSectionWidgetState();
}

class _LoginSectionWidgetState extends State<LoginSectionWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  final AuthController authController = Get.put(AuthController());
  final LoginFormController loginFormController =
      Get.put(LoginFormController());

  @override
  void initState() {
    emailController.text = loginFormController.emailInit.value;
    passwordController.text = loginFormController.passwordInit.value;
    super.initState();
  }
  // @override
  // void dispose() {
  //   loginFormController.onClose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Obx(
                () => CustomAuthTextFormFieldWidget(
                  borderColor: loginFormController.borderEmail.value,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  errorText: loginFormController.errorEmail.value,
                  controller: emailController,
                  onChanged: (value) {
                    loginFormController.validatorEmail(value);
                  },
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Obx(
                () => CustomAuthTextFormFieldWidget(
                  borderColor: loginFormController.borderPassword.value,
                  hintText: 'Password',
                  showPassword: showPassword,
                  controller: passwordController,
                  errorText: loginFormController.errorPassword.value,
                  onChanged: (value) {
                    loginFormController.validatorPassword(value);
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: showPassword ? Colors.black26 : Colors.black54,
                        size: 20,
                      )),
                ),
              ),
              const SizedBox(
                height: 47.0,
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
                    await authController.login(loginParams: loginParams);
                  },
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              Text(
                'Or',
                style: GoogleFonts.nunito(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9ba5b7)),
              ),
              const SizedBox(
                height: 14.0,
              ),
              const CustomLoginGoogleWidget()
            ],
          ),
        )
      ],
    );
  }
}
