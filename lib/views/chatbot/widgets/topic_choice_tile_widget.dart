import 'package:flutter/material.dart';

import '../../../constants/text_style_constant.dart';

class TopicChoiceTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  const TopicChoiceTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Container(
                width: 78,
                margin: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  'assets/vectors/plant-dummy.png',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyleConstant.boldText.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyleConstant.regular.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
