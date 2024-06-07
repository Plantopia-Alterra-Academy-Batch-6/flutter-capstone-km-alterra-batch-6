import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAuthAppbarWidget extends StatelessWidget {
  const CustomAuthAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(
            height: 32.0,
          ),
          Text(
            'Welcome Back',
            style: GoogleFonts.nunito(
                color: const Color(0xFF030712),
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Text(
            "It's good to see you again!",
            style: GoogleFonts.nunito(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
