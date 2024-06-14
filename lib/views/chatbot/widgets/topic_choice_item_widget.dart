import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopicChoiceItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isEnabled;
  final String vector;

  const TopicChoiceItem({
    super.key,
    required this.text,
    required this.onTap,
    this.isEnabled = true,
    required this.vector,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 155,
        height: 164,
        padding:
            const EdgeInsets.only(top: 24, left: 21, bottom: 24, right: 21),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEnabled
                ? const Color(0xFFD1D5D7)
                : Colors.grey.withOpacity(0.5),
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
                style: TextStyle(
                  fontSize: 12,
                  color: isEnabled ? const Color(0xFF707A85) : Colors.grey,
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
