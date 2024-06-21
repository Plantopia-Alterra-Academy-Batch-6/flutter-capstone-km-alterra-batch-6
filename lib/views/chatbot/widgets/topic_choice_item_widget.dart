import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopicChoiceItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String vector;

  const TopicChoiceItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.vector,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 155,
        height: 164,
        padding:
            const EdgeInsets.only(top: 24, left: 21, bottom: 24, right: 21),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFD1D5D7),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: SvgPicture.asset(
                vector,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF707A85),
                ),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
