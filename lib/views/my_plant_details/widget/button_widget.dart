import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.buttonName,
      required this.boxDecoration,
      required this.textStyle,
      this.onTap});
  final String buttonName;
  final BoxDecoration boxDecoration;
  final TextStyle textStyle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 14),
          height: 52,
          decoration: boxDecoration,
          child: Center(
            child: Text(buttonName, style: textStyle),
          ),
        ));
  }
}
