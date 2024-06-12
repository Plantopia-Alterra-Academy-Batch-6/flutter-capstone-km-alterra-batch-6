import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';

import '../../../constants/color_constant.dart';

class TypingIndicatorWidget extends StatelessWidget {
  final ChatUser user;
  final List<ChatUser> typingUsers;

  const TypingIndicatorWidget({
    super.key,
    required this.user,
    required this.typingUsers,
  });

  @override
  Widget build(BuildContext context) {
    if (typingUsers.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 8),
              TypingIndicator(
                flashingCircleBrightColor: ColorConstant.primary500,
                flashingCircleDarkColor: Color(0xFFECFDF5),
              ),
              const SizedBox(width: 3),
              Text(
                '${user.firstName}',
                style: TextStyleConstant.paragraph.copyWith(
                  color: ColorConstant.primary500,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                ' is typing',
                style: TextStyleConstant.paragraph.copyWith(
                  color: ColorConstant.primary500,
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
