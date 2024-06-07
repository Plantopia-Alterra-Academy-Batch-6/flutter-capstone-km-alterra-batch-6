// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/models/login_params_model.dart';

class VerificationView extends StatefulWidget {
  final LoginParamsModel loginParamsModel;
  const VerificationView({super.key, required this.loginParamsModel});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  Color? colorCurrent;
  final AuthController authController = Get.put(AuthController());
  Timer? _timer;
  int _start = 0;

  void startTimer() {
    setState(() {
      _start = 10; // Mengatur waktu menjadi 60 detik
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            const CustomAppbarVerifyWidget(),
            const SizedBox(
              height: 32.0,
            ),
            const ConfirmDescriptionWidget(),
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Obx(
                () => OtpTextField(
                  autoFocus: true,
                  numberOfFields: 6,
                  filled: true,
                  showFieldAsBox: true,
                  fieldWidth: 53,
                  borderWidth: 0.5,
                  enabledBorderColor: authController.borderVerifyColor.value,
                  focusedBorderColor: Colors.black,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  disabledBorderColor: Colors.red,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textStyle: TextStyle(color: colorCurrent ?? Colors.black),
                  borderRadius: BorderRadius.circular(12),
                  onSubmit: (String otpUser) async {
                    final LoginParamsModel? result =
                        await authController.verification(
                            loginParams: widget.loginParamsModel, otp: otpUser);

                    if (result != null) {
                      alertsuccess(context);

                      //melakukan login otomatis ketika akun telah verifikasi
                      await authController.login(loginParams: result);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  "Didn’t receive the code? ",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                TextButton(
                  style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                  onPressed: _start == 0
                      ? () async {
                          await authController.resendOTP(
                              email: widget.loginParamsModel.email);
                          startTimer();
                        }
                      : null,
                  child: Text(
                    _start == 0 ? "Resend it" : "Resend in $_start",
                    style: TextStyle(
                      color:
                          _start == 0 ? const Color(0xFF10B981) : Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void alertsuccess(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(24),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/onboarding/success.svg'),
                  const Text(
                    "Yay!",
                    style: TextStyle(
                        color: Color(0xFF545F71),
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      textAlign: TextAlign.center,
                      'You’ve successfully signed up. Excited to grow with you! 🌿',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ));
        });
  }
}

class ConfirmDescriptionWidget extends StatelessWidget {
  const ConfirmDescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Confirm Your Credentials",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        SizedBox(
          height: 8.0,
        ),
        SizedBox(
          width: 270,
          child: Text(
            textAlign: TextAlign.center,
            'We’ve send code to your email,  please type the code here',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class CustomAppbarVerifyWidget extends StatelessWidget {
  const CustomAppbarVerifyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF030712)),
                borderRadius: BorderRadius.circular(12)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15,
                )),
          ),
          const Text(
            "Verify Identity",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(
            width: 40.0,
          ),
        ],
      ),
    );
  }
}
