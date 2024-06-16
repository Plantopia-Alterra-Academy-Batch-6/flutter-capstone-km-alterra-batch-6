import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomAppbarForgotPasswordWidget extends StatelessWidget {
  const CustomAppbarForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text('Forgot Password',
                  style: TextStyleConstant.heading3
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 7.0,
              ),
              Text(
                "Enter your email and get instruction for resetting your password",
                style: TextStyleConstant.paragraph.copyWith(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
