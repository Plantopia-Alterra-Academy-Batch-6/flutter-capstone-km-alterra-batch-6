// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomFormfieldForgotPasswordWidget extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool showPassword;
  final String? errorText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Color borderColor;
  final Color? textColor;
  final String? initialValue;
  final FocusNode? focusNode;
  const CustomFormfieldForgotPasswordWidget(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.showPassword = false,
      this.errorText,
      this.controller,
      this.onChanged,
      this.focusNode,
      this.initialValue,
      this.textColor,
      this.borderColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyleConstant.paragraph
              .copyWith(color: textColor, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 4.0,
        ),
        TextFormField(
          initialValue: initialValue,
          style: TextStyle(color: textColor),
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: showPassword,
          obscuringCharacter: '*',
          focusNode: focusNode,
          cursorColor: const Color(0xFFD1D5DB),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            errorText: errorText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}
