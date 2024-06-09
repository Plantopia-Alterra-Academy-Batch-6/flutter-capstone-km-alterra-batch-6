// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAuthTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool showPassword;
  final String? errorText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Color borderColor;
  final String? initialValue;
  const CustomAuthTextFormFieldWidget(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.showPassword = false,
      this.errorText,
      this.controller,
      this.onChanged,
      this.initialValue,
      this.borderColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style:
              GoogleFonts.nunito(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 4.0,
        ),
        TextFormField(
          initialValue: initialValue,
          style: TextStyle(color: borderColor),
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: showPassword,
          obscuringCharacter: '*',
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
