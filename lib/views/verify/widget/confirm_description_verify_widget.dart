import 'package:flutter/material.dart';

class ConfirmDescriptionWidget extends StatelessWidget {
  const ConfirmDescriptionWidget({super.key});

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
