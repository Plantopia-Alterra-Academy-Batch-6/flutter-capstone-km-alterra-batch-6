import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:plantopia/constants/color_constant.dart';

import '../../../constants/text_style_constant.dart';

class MessageTextWidget extends StatelessWidget {
  final ChatMessage message;
  final ChatMessage? previousMessage;
  final ChatMessage? nextMessage;
  final ChatUser currentUser;

  const MessageTextWidget({
    super.key,
    required this.message,
    this.previousMessage,
    this.nextMessage,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: message.text,
      styleSheet: MarkdownStyleSheet(
        p: TextStyleConstant.paragraph.copyWith(
          color:
              message.user.id == currentUser.id ? ColorConstant.white : ColorConstant.neutral950,
        ),
      ),
    );
  }
}
