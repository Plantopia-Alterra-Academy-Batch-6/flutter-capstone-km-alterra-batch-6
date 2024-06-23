// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomFormfieldForgotPasswordWidget extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool showPassword;
  final String? errorText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? initialValue;

  const CustomFormfieldForgotPasswordWidget({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.showPassword = false,
    this.errorText,
    this.controller,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style:
              TextStyleConstant.paragraph.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 4.0,
        ),
        TextFormField(
          initialValue: initialValue,
          style: TextStyle(
              color: errorText != null ? Colors.red : ColorConstant.neutral950),
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: showPassword,
          obscuringCharacter: '*',
          cursorColor: const Color(0xFFD1D5DB),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyleConstant.subtitle
                .copyWith(color: ColorConstant.neutral400),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorConstant.neutral100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : ColorConstant.neutral950),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : ColorConstant.neutral950),
            ),
            errorText: errorText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : ColorConstant.neutral400),
            ),
          ),
        ),
      ],
    );
  }
}
