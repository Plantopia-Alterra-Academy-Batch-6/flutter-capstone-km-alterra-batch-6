// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/sign_up_form_controller.dart';
import 'package:plantopia/models/signup_params_model.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_button_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_text_form_field_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_login_google_widget.dart';
import 'package:plantopia/views/auth/widgets/custom_text_button_forgot_password_widget.dart';

class SignUpSectionWidget extends StatefulWidget {
  const SignUpSectionWidget({super.key});

  @override
  State<SignUpSectionWidget> createState() => _SignUpSectionWidgetState();
}

class _SignUpSectionWidgetState extends State<SignUpSectionWidget> {
  bool showPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final SignUpFormController signUpController = Get.put(SignUpFormController());
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    nameController.text = signUpController.nameInit.value;
    emailController.text = signUpController.emailInit.value;
    passwordController.text = signUpController.passwordInit.value;
    super.initState();
  }

  // @override
  // void dispose() {
  //   signUpController.onClose();
  //   super.dispose();
  // }

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
                  isEnable: signUpController.isEnableButtonName.value,
                  controller: nameController,
                  hintText: 'Name',
                  errorText: signUpController.errorName.value,
                  onChanged: (e) => signUpController.setName(e),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Obx(
                () => CustomAuthTextFormFieldWidget(
                  isEnable: signUpController.isEnableButtonEmail.value,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  errorText: signUpController.errorEmail.value,
                  onChanged: (e) => signUpController.setEmail(e),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Obx(
                () => CustomAuthTextFormFieldWidget(
                  isEnable: signUpController.isEnableButtonPassword.value,
                  controller: passwordController,
                  hintText: 'Password',
                  showPassword: showPassword,
                  errorText: signUpController.errorPassword.value,
                  onChanged: (e) => signUpController.setPassword(e),
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
              const CustomTextButtonForgotPasswordWidget(),
              const SizedBox(
                height: 24.0,
              ),
              Obx(
                () => CustomAuthButtonWidget(
                    isActive: signUpController.isEnableButtonName.value &&
                        signUpController.isEnableButtonEmail.value &&
                        signUpController.isEnableButtonPassword.value,
                    text: 'Sign Up',
                    onPressed: () async {
                      SignUpParamsModel data = SignUpParamsModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      await authController.signUp(data);
                    }),
              ),
              const SizedBox(
                height: 14.0,
              ),
              Center(
                child: Text(
                  'Or',
                  style: GoogleFonts.nunito(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9ba5b7)),
                ),
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
